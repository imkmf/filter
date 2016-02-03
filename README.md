this is filter, an app i built a long time ago to manage a podcast directly from soundcloud.

this informed a lot of later work i did with stripe, job queues, etc. and was a great tool to build for interviewing at places. read through the source, though it might not be great by today's standards!

operating
===

server:

`bundle exec rails server` (probably, i haven't booted it up in forever)

jobs:

`rake resque:work`

`rake resque:scheduler`

