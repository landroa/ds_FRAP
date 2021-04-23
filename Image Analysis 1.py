# run this code cell to import the necessary libraries
import numpy as np
import matplotlib.pyplot as plt
from   skimage import io, transform, color

url = 'C:/Users/aboot/OneDrive/Documents/2020-2021/Semester 2/BME 395/Module 2/test3.JPG'
#url = 'https://drive.google.com/uc?id=1ey_LREvBHj8l218yQvtTtZiJrAf3iid6'
#url = 'https://drive.google.com/uc?id=1ZIjcVOcxtwC04NcISjuFG4adEVJIJvEW'
#url = 'https://drive.google.com/uc?id=1Ng6MxQGi60uxuTpklvVdkjqb5VE3yrod'

im = io.imread(url)
plt.imshow(im)

print('Image Dimensions:', np.shape(im))

#plt.imshow(im[:,:,-1])
print('Alpha channel has no unique positional information')
#plt.colorbar()

im = im[:,:,:3]

#plt.figure()
#plt.imshow(im)
print('New image dimensions:', np.shape(im))

# threshold value between 0 and 255
th = 100

# axis=-1 specifies we're working with the last dimension of 
# image (i.e. the RGB color information)
background = np.all(im >= [th, th, th], axis=-1)

# the '~' character inverts the background mask
# you could equivalently write np.not(background)
foreground = ~background

# plot the image, the foreground and then the background
#fig, (ax1, ax2, ax3) = plt.subplots(nrows=1,ncols=3)
#plt.subplots_adjust(wspace=2)

#ax1.imshow(im); ax1.set_title('Original')
#ax2.imshow(background); ax2.set_title('Background')
#ax3.imshow(foreground); ax3.set_title('Foreground')

foreground_ = np.expand_dims(foreground, axis=-1)
fluid = im*foreground_

# -1 is outside the display range of 0 to 255
# so these values are not shown
fluid[np.all(fluid == [0,0,0], axis=-1)] = [-1,-1,-1]

plt.figure()
plt.imshow(fluid)

def channelSplit(image):

    channel1 = image[:,:,0]
    channel2 = image[:,:,1]
    channel3 = image[:,:,2]

    return [channel1, channel2, channel3]

def channelPlot(channels,titles=['1','2','3']):
    
    fig, axs = plt.subplots(nrows=1,ncols=len(channels))

    for ax, title, channel in zip(fig.axes, titles, channels):
        ax.set_title(title)
        ax.imshow(channel,cmap='Greys') 
        ax.axis('off')

print('Functions successfully defined.')

rgb = channelSplit(im)
channelPlot(rgb,'rgb')

gray = color.rgb2gray(fluid)
hsv = color.rgb2hsv(fluid)
lab = color.rgb2lab(fluid)

h,s,v = channelSplit(hsv)
l,a,b = channelSplit(lab)

channelPlot([h,s,v],'hsv')
channelPlot([l,a,b],'lab')

plt.figure()
plt.imshow(gray,cmap='Greys')

fig, (ax1,ax2) = plt.subplots(nrows=1,ncols=2)

ax1.imshow(fluid)
ax2.imshow(a,cmap='Greys')

fig, (ax1,ax2) = plt.subplots(nrows=1,ncols=2)

ax1.imshow(fluid)
ax2.imshow(a,cmap='Greys')

nrows, ncols, nchannels= np.shape(fluid)
midpt_slice = a[nrows//3,:]

plt.plot(midpt_slice)

th = .15 # threshold value
print(np.shape(a))

mix = a <= th

mix_mask = np.expand_dims(mix, axis=-1)
diffuse = fluid*mix_mask
diffuse[np.all(diffuse==[0,0,0],axis=-1)] = [255,255,255]

fig, (ax1,ax2,ax3) = plt.subplots(1,3)
ax1.imshow(im)
ax2.imshow(mix)
ax3.imshow(diffuse)

from scipy import ndimage as ndi

mix_width = np.count_nonzero(mix,axis=1)

fig, (ax1,ax2) = plt.subplots(2,1)

rotated = ndi.rotate(diffuse,90)
ax1.imshow(rotated, aspect='auto')

ax2.plot(range(0,len(mix_width)),mix_width)
ax2.set_xlim(left=0)


