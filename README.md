Some python tools to work with annotation created with [labelme](http://labelme.csail.mit.edu/)

# show_labelme

Tool shows image with labels on the screen.

Example of input image: 
![Input](https://git.fit.vutbr.cz/imlich/labelme-pytools/raw/master/data/Image/000092.jpg)

Example of Annotaion XML:

```xml
<annotation>
    <filename>000092.jpg</filename>
    <folder>fire</folder>
    <source>
        <sourceImage>The MIT-CSAIL database of objects and scenes</sourceImage>
        <sourceAnnotation>LabelMe Webtool</sourceAnnotation>
    </source>
    <object>
        <name>fire</name>
        <deleted>0</deleted>
        <verified>0</verified>
        <occluded>no</occluded>
        <attributes/>
        <parts>
            <hasparts/>
            <ispartof/>
        </parts>
        <date>18-Dec-2017 13:40:42</date>
        <id>0</id>
        <polygon>
            <username>test</username>
            <pt>
                <x>776</x>
                <y>671</y>
            </pt>
            <pt>
                <x>923</x>
                <y>642</y>
            </pt>
            <pt>
                <x>966</x>
                <y>638</y>
            </pt>
            <pt>
                <x>864</x>
                <y>569</y>
            </pt>
            <pt>
                <x>863</x>
                <y>490</y>
            </pt>
            <pt>
                <x>790</x>
                <y>477</y>
            </pt>
            <pt>
                <x>769</x>
                <y>484</y>
            </pt>
            <pt>
                <x>760</x>
                <y>550</y>
            </pt>
            <pt>
                <x>712</x>
                <y>604</y>
            </pt>
        </polygon>
    </object>
    <object>
        <name>fire</name>
        <deleted>0</deleted>
        <verified>0</verified>
        <occluded>no</occluded>
        <attributes/>
        <parts>
            <hasparts/>
            <ispartof/>
        </parts>
        <date>18-Dec-2017 13:40:48</date>
        <id>1</id>
        <polygon>
            <username>test</username>
            <pt>
                <x>868</x>
                <y>454</y>
            </pt>
            <pt>
                <x>969</x>
                <y>484</y>
            </pt>
            <pt>
                <x>1048</x>
                <y>450</y>
            </pt>
            <pt>
                <x>974</x>
                <y>373</y>
            </pt>
            <pt>
                <x>869</x>
                <y>382</y>
            </pt>
            <pt>
                <x>784</x>
                <y>400</y>
            </pt>
        </polygon>
    </object>
    <object>
        <name>fire</name>
        <deleted>0</deleted>
        <verified>0</verified>
        <occluded>no</occluded>
        <attributes/>
        <parts>
            <hasparts/>
            <ispartof/>
        </parts>
        <date>18-Dec-2017 13:40:52</date>
        <id>2</id>
        <polygon>
            <username>test</username>
            <pt>
                <x>1028</x>
                <y>639</y>
            </pt>
            <pt>
                <x>1075</x>
                <y>552</y>
            </pt>
            <pt>
                <x>1107</x>
                <y>573</y>
            </pt>
            <pt>
                <x>1107</x>
                <y>623</y>
            </pt>
            <pt>
                <x>1085</x>
                <y>663</y>
            </pt>
            <pt>
                <x>1045</x>
                <y>680</y>
            </pt>
        </polygon>
    </object>
    <object>
        <name>fire</name>
        <deleted>0</deleted>
        <verified>0</verified>
        <occluded>no</occluded>
        <attributes/>
        <parts>
            <hasparts/>
            <ispartof/>
        </parts>
        <date>18-Dec-2017 13:40:58</date>
        <id>3</id>
        <polygon>
            <username>test</username>
            <pt>
                <x>769</x>
                <y>349</y>
            </pt>
            <pt>
                <x>811</x>
                <y>330</y>
            </pt>
            <pt>
                <x>833</x>
                <y>287</y>
            </pt>
            <pt>
                <x>834</x>
                <y>216</y>
            </pt>
            <pt>
                <x>803</x>
                <y>222</y>
            </pt>
            <pt>
                <x>785</x>
                <y>238</y>
            </pt>
        </polygon>
    </object>
    <imagesize>
        <nrows/>
        <ncols/>
    </imagesize>
</annotation>
```

[Annotation](https://git.fit.vutbr.cz/imlich/labelme-pytools/raw/master/data/Annotation/000092.xml)

![Output](https://git.fit.vutbr.cz/imlich/labelme-pytools/raw/master/data/Output/000092.jpg)

usage: show_labelme.py image.jpg labelme.xml


- e.g. test_show_labelme.sh

# save_labelme

Tool renders same image as show_labelme, but into output.jpg

usage: save_labelme.py image.jpg labelme.xml output.jpg

- e.g. save_all_labels.sh

# save_labelme_samples

usage: save_labelme_samples.py image.jpg labelme.xml outputdir class

- walk over image with window 48x48 and step 16x16
- check if center pixel is in class defined in argv
- renders every such region in separate picture

![Sample1](https://git.fit.vutbr.cz/imlich/labelme-pytools/raw/master/data/Samples/000092_0.jpg)
![Sample2](https://git.fit.vutbr.cz/imlich/labelme-pytools/raw/master/data/Samples/000092_100.jpg)
![Sample3](https://git.fit.vutbr.cz/imlich/labelme-pytools/raw/master/data/Samples/000092_10.jpg)
![Sample4](https://git.fit.vutbr.cz/imlich/labelme-pytools/raw/master/data/Samples/000092_1.jpg)


- e.g. test_samples.sh
- e.g. save_all_samples.sh

