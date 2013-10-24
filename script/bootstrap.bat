rem "For those who are not privileged by using UNIX systems at work ;D"

@echo off

rem "Make sure all our deps exist."

rem "Export CC to explicitly set the compiler used for cexts."

rem "TODO - Verify this, maybe shit happens with the C compiler"

set CC=cc

rem "Generate .bundle/config instead of using env vars or command line"
rem "flags so that we have consistent configuration for our `bundle"
rem "check` and `bundle install` calls here, as well as any manual calls"
rem "to `bundle` that people might make."

rem "We don't want old config hanging around right now. This is sorta"
rem "jank: We can do better."

del /S /F /Q .bundle
rd /S /Q .bundle
mkdir .bundle

rem "So, each line of the file need to be an echo in batch"

>.bundle\config  echo BUNDLE_BIN: bin
>>.bundle\config echo BUNDLE_DISABLE_SHARED_GEMS: 1
>>.bundle\config echo BUNDLE_PATH: vendor/gems
>>.bundle\config echo BUNDLE_WITHOUT: staging:production

rem "TODO - I'm doing 'bundle install' everytime, try to do it a better way"
rem "someday, when batch turns in a decent shell script"

bundle install %*
