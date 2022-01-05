########################################################################
# Dependancy layer
# Gem are installed, assets are compiled. All build libraries to compiles
# decidim gems are already installed.
########################################################################
FROM git.octree.ch:4567/decidim/decidim-quickstart/0.24:quickstart-latest  AS quickstart
LABEL maintainer="hello@octree.ch"

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . ./

RUN source $NVM_DIR/nvm.sh; nvm use $NODE_VERSION && \
    SECRET_KEY_BASE=assets bundle exec rails assets:precompile

########################################################################
# Final layer
# Go back to an alpine image, with the bare minimum. Will copy
# gem binaries and assets from the dependancy layer
########################################################################
FROM git.octree.ch:4567/decidim/decidim-quickstart/0.24:build-alpine-latest
LABEL maintainer="hello@octree.ch"

VOLUME /home/$USER/app/storage
VOLUME /home/$USER/app/public
VOLUME /home/$USER/app/log

COPY --from=quickstart /usr/local/bundle/ /usr/local/bundle/
COPY --chown=$USER:$GROUP --from=quickstart /home/$USER/app ./

RUN bundle exec bootsnap precompile --gemfile app/ lib/