# drawCircleImage
A program that transform an image into a bunch of circles easily. The window will get bigger towards the end of the process, it's normal it's due to the way I use to upscale the picture. The picture will be save in an subfile call "output". This program is made in Processing (there website: https://processing.org/) and utilise the library call "Drop" (the website: http://transfluxus.github.io/drop/ | you can simply download it from Processing tho) to allow the user to drag and drop is picture onto the program. 

The settings: (if they are gray they are active)
FAST: Do not put a limit to the ammount of frame per second the program generate (let it at true preferably). | If you click on the key 'f' once the program as started the conversion you will be able to active and desactive this option.

COL: Change the way that the program allow it self to continu letting the circle grow, if active a color too different (dertermine with DIFF) of the one at the center of the circle in the original picture the circle will stop growing, if desactive a color too dark (dertermine with DIFF) will make the circle will stop growing. 

B&W: Make the picture be in black and white or in gray tone if you want the precision.

BACK: Get rid of the white and the color that are to bright (dertermine with DIFF) of the original picture, use it if there is an unwanted white background, but that inversing the color is not an option for you.

INV: Inverse the color of the original picture.

FILL: Fill the circles during the creation of the circles (two pictures will be created at the end: with and without filling the circles). | If you click the key 'x' once the program as started the conversion you will be able to active and desactive this option.

IMG: Show the modified original picture with transparency under the circles during the creation of the circles (it will not be on the final exported picture) | If you click on the key 'i' once the program as started the conversion you will be able to active and desactive this option.

WAIT: Wait until the end of the creation of the last circle to start the next one, if desactive the slider call NEW will appear.

NEW: The ammount of new circles created by frame or per loop of the program if you want. It will appear only if WAIT is desactive.

LOOP: The ammount of mistake tolerate in the creation of a new circle (mistake are when the program fail at finding an unuse position in a random way) before the window is taken in picture. 

REZ: The honrizontal resolution (default: 4320) the bigger it is the bigger the window will became during the take of the picture. 

DIFF: The darkess color accepted (0 = total black | 255 = absolute white).


Chosing the picture: 

Way 1:
The picture need to be in the same folder then the executable or in a subfolder call "data" or you will need to enter the whole path.
You will need to enter the name of the picture manually in the text box and press enter to begin.

Way 2:
Drag the picture on the window of the application to begin (the picture need to be on the computer).
