#!/bin/bash
ASSETS_PRECOMPILED=${RAILS_ASSETS_PRECOMPILED:-"tmp/precompiled_assets.tar.cz"}
if [ -f "$ASSETS_PRECOMPILED" ]; then
    echo "extracting assets $ASSETS_PRECOMPILED to /public volume"
    chown $USER:$GROUP $ASSETS_PRECOMPILED
    mv "$ASSETS_PRECOMPILED" $RAILS_ROOT/precompiled_assets.tar.cz
    tar xvfz $RAILS_ROOT/precompiled_assets.tar.cz
fi

if [ $1 = "puma" ]
then
    bundle exec rails server puma
elif [ $1 = "sidekiq" ]
then
    bundle exec sidekiq
fi