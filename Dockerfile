########################################################################
# Dependancy layer
# Gem are installed, assets are compiled. All build libraries to compiles
# decidim gems are already installed.
########################################################################
FROM git.octree.ch:4567/decidim/decidim-quickstart/0.24:quickstart-latest  AS build
LABEL maintainer="hello@octree.ch"

# Install gems
COPY Gemfile Gemfile.* ./
RUN bundle config set --local deployment 'true' && \
    bundle install
    
# Remove quickstart migrations, and use ours
RUN rm -rf db/migrate
COPY . .

RUN source $NVM_DIR/nvm.sh; nvm use $NODE_VERSION && \
    SECRET_KEY_BASE=assets bundle exec rails assets:precompile

RUN mkdir -p tmp && tar cfvz tmp/precompiled_assets.tar.cz ./public/assets

########################################################################
# Final layer
# Go back to an alpine image, with the bare minimum. Will copy
# gem binaries and assets from the dependancy layer
########################################################################
FROM git.octree.ch:4567/decidim/decidim-quickstart/0.24:toolkit-alpine-latest
LABEL maintainer="hello@octree.ch"
ENV DECIDIM_PROCESS="puma"
COPY --from=build /usr/local/bundle/ /usr/local/bundle/
COPY --from=build --chown=$USER:$GROUP /home/$USER/app .

RUN bundle binstubs --all && \
    crontab $RAILS_ROOT/config/crontab && \
    rm $RAILS_ROOT/config/crontab && \
    mv start.sh bin/start.sh
    
CMD ["bin/start.sh $DECIDIM_PROCESS"]