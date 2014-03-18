LightLauncher
============
An open-sourced, light-weight (and perhaps bad) clone of Lauch Center Pro.
- It does not only support `x-callback-url` but also other native SDKs/APIs. So users can do things like: share last taken photo to multiple social networks, share current photo in clipboard to multiple social networks, open url in clipboard in Chrome, etc.
- The architecture is designed to be extensible. It's (supposedly) easy to add new commands or new parameters to an existing command.
- Commands always have a readable JSON representation. Before executing, JSON form of a command is validated and "parsed" to runtime object. Then, the object is "compiled" to include runtime values (current photo in clipboard, for example). After that, the command is ready to be executed.
- Since a command must have a readable JSON representation, the JSON text can be stored in CoreData, reused multiple times and shared to other users. If a user is hardcore enough, he can even write a JSON string and execute it using the app. 

License
=======
The MIT License (MIT)

Copyright (c) 2013 Huy Thanh Nguyen

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
