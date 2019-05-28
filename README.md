# FFmpeg for Android

Build FFmpeg 4.0 for Android (ARM EABI5 32bit), using NDK r10e.


# Instructions

You can run `./docker-build ; ./docker-build` or, manually:

```
mkdir -p out
docker build -t ffmpeg-android .
docker run -ti --rm -v `pwd`/out:/out ffmpeg-android
```

The output will be placed in the **out** directory.


# License and copyright

Copyright 2019 DIVUS GmbH

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

All third-party code is released under their respective licenses.

