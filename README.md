Do location updates work?
=========================

This tests whether *deferred* location updates work on some hardware.  You'll need to run this on an actual iOS device, which probably means using xcode and having a provisioning profile ready to go.

## To test
1. Clone this repo, and run it a device
2. Wait ~5 seconds, and see a big 'yes!' or a big 'no!'

## Test results (so far)
<table>
    <tr>
        <td><strong>Device</strong></td>
        <td><strong>iOS</strong></td>
        <td><strong>works?</strong></td>
    </tr>
    <tr>
        <td>iphone 4s</td>
        <td>7.1</td>
        <td>no</td>
    </tr>
    <tr>
        <td>iphone 5</td>
        <td>7.1</td>
        <td>yes</td>
    </tr>
</table>
