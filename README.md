# RainbowsAndBlood-A-Minecraft-shader-for-snapshot-21w10a

![Shader demonstration: Minecraft leaves with a weird moving rainbow effect and Minecraft water becoming blood-red when the player gets closer](shaderDemos.gif)

## A (demo) resource pack with SHADERS for latest 1.17 snapshot (21w10a) ##

Based on [@Xilefian](https://twitter.com/Xilefian)'s [demo](https://twitter.com/Xilefian/status/1369677620561014784): https://gist.github.com/felixjones/d5bec1ab0c83ee134fa43a142692a09b

In addition to the initial resource pack (which adds wubbling leaves and water), it does the following:
* Fancy animated rainbow leaves
* Water becomes blood-red when you get close to it

*(Please note that it may not work in any other Minecraft snapshots/releases or if any other resource packs is installed. Or not at all. I will not update it.)*

---

The (code) changes made to the original are the following:
* rendertype_cutout_mipped.vsh
    * All occurences of `modifiedRed`, `modifiedGreen` and `modifiedBlue` and their addition to `Color` at the end
    * I basically use the same animation logic that was used, but to generate some values and add their squares to the result color's RGB chanels (squared values makes the rainbow more *rainbowy*)
* rendertype_translucent.vsh
    * All occurences of `colorModifier` and its addition to `Color` at the end
    * I basically use the already existing vertex distance (distance to the player, I guess) to generate a value that I use to modify the result color's RGB chanels (add it to red chanel and substract it from green and blue chanels)
    * `8 * (1 / vertexDistance) * (1 / vertexDistance)`:
        * `(1 / vertexDistance)` so the closer we are, the higher to value will get
        * Squared to make the effect sharper
        * Multiplied by 8 because I liked the result it gives us

*(Please note that I never used OpenGL and have no clue of how it works. The code is probably terrible, it was just a test. I can't provide support on how shaders works.)*

---

As [@Xilefian](https://twitter.com/Xilefian) stated, it uses a [dirty trick with the UV map](https://twitter.com/Xilefian/status/1369695626921967622) to select which block are targetted. It is for demo purpose and should **NOT** be reproduced in the future.

As far as I understand, the different files are used to modify the different rendertypes, and the conditions are used to target the desired blocks based on their texture position on the corresponding UV map (that's the dirty trick).
