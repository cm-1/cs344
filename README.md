# About this fork

This is my fork of the Github directory supplied by Udacity for their cs344 course,
"Introduction to Parallel Programming".

At the time of updating this README, I've only attempted the first two problem sets.
If I have time and think it's relevant to my research, I'll return to attempt the others
at a later date.

My changes to CMakeLists.txt are a bit non-ideal for including OpenCV because I guess there's
something with my built-from-source Windows 10 OpenCV installation that maybe didn't go
as `find_package()` would expect. Since I currently don't have time to debug that,
I went with a hard-coded path for now. The changes to the setting of `CUDA_NVCC_FLAGS` 
could also possibly be improved, but I don't have time to research that at the moment.

For other notes/info, see the "otherPics" directory, as well as some .txt notes
I've made in the various Lesson Code Snippets and Problem Sets directories. There are also notes/files
I've left for my reference in the "stuffToGitignore", but I have not committed them primarily out of
IP/copyright concerns.

# TODO

I currently wrote my HW2 solution where pixels near any of the four edges are responsible
for copying the "halo" pixels outside of the block into shared memory.
Another solution I found online, though, shifts things so that most pixels just copy one pixel,
but it's the one shifted by (-halfFilterWidth, -halfFilterWidth) relative to them instead
of the one exactly matching their coordinates, and then for all pixels within the "full"
filterWidth - 1 from the two "max" edges, they copy extra pixels to the sides as needed.
After doing some reading about what warps are, I realize this way is probably better for minimizing
warp divergence. So I'd probably rewrite mine to match.

And then, of course, I need to finish all of the problems after HW2 at some point.

I'd also like to improve CMakeLists.txt, especially the `CUDA_ARCHITECTURES` part.

# Good other forks to look at:

The README for https://github.com/ernestyalumni/cs344 looks super comprehensive, especially in its discussion of HW2.
It also links a paper that analyzes optimal block sizes for stencils. 
"Demystifying the 16 x 16 thread-block for stencils on the GPU" by Tabik _et al._

The README of https://github.com/ilyakava/cs344 seems to contain a really good list of other resources.


**<span style="color:red">The contents of Udacity's original README are below.</span>**

<hr/>
cs344
=====

Introduction to Parallel Programming class code

# Building on OS X

These instructions are for OS X 10.9 "Mavericks".

* Step 1. Build and install OpenCV. The best way to do this is with
Homebrew. However, you must slightly alter the Homebrew OpenCV
installation; you must build it with libstdc++ (instead of the default
libc++) so that it will properly link against the nVidia CUDA dev kit. 
[This entry in the Udacity discussion forums](http://forums.udacity.com/questions/100132476/cuda-55-opencv-247-os-x-maverick-it-doesnt-work) describes exactly how to build a compatible OpenCV.

* Step 2. You can now create 10.9-compatible makefiles, which will allow you to
build and run your homework on your own machine:
```
mkdir build
cd build
cmake ..
make
```

