Do location updates work?
=========================

This tests whether *deferred* location updates work on some hardware.  You'll need to run this on an actual iOS device, which probably means using xcode and having a provisioning profile ready to go.

## To test
1. Clone this repo, and run it a device
2. Wait ~5 seconds, and see a big 'yes!' or a big 'no!'

## Test results (so far)

| Device    | iOS | works? |
|:---------:|:---:|:------:|
| iPhone 4S | 7.1 | no     |
| iPhone 5  | 7.1 | yes    |
| iPhone 5s | 7.1 | yes    |
