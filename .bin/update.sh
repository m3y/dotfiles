#!/bin/sh

brew update
brew upgrade
brew cask cleanup
for c in `brew cask list`; do
    ! brew cask info $c | grep -qF "Not installed" || brew cask install $c;
done
