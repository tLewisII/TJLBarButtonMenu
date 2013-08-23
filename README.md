<h1>TJLBarButtonMenu</h1>
A simple 3 button menu that is meant to be launched from a bar button item.
![Two Buttons](http://ploverproductions.com/images/TJLBarButtonMenuL.png?raw=true)&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
![One Buttons](http://ploverproductions.com/images/TJLBarButtonMenuR.png?raw=true)
<h2>Installation</h2>
<hr>
[Cocoapods](http://www.cocoapods.org) support is forth coming, in the meantime, just grab the source folder and drop it into your project.
<h2>Usage</h2>
<hr>
`+initWithViewController:images:buttonTitles:position:`<br>
`-setButtonTappedBlock:`<br>
`-show`<br>
**and thats it!**

Currently the view only supports 2 or 3 images, it looks best with 3. Both top-left and top-right sides of the screen are currently available,
and I may add support for bottom left and bottom right as well.

The button titles are set for the buttons `disabled` state, and are only used to let you know which button was tapped,
so button titles should follow their purpose, as you will get sent the title of the tapped button.

Auto layout is also used, so all interface orientations and rotations are supported.
<br><br>


<h1>License</h1>
If you use TJLBarButtonMenu and you like it, feel free to let me know, <terry@ploverproductions.com>. If you have any issue or want to make improvements, submit a pull request.<br><br>

The MIT License (MIT)
Copyright (c) 2013 Terry Lewis II

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
<br><br>
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
<br><br>
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
