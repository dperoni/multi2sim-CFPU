use File::Copy;

#@benchs = ("airplanes", "brontosaurus", "cougar_face", "elephant", "Faces_easy", "grand_piano", "laptop", "nautilus", "rhino", "windsor_chair");

#@benchs = ("accordion","brain","cougar_body","electric_guitar","Faces","gramophone","lamp","Motorbikes","revolver","wild_cat", "airplanes", "brontosaurus", "cougar_face", "elephant", "Faces_easy", "grand_piano", "laptop", "nautilus", "rhino", "windsor_chair");
@benchs = ("10000");
@fifo_list = (0); #8, 16, 32, 64, 128, 256);
$dist = 0;
@fdist = (0, 0.015625, 0.03125, 0.0625, 0.125, 0.25, 100);
@buffsize = (0);

$ENV{M2S_OPENCL_BINARY}='/home/dperoni/rodinia_3.1/opencl/kmeans/kmeans.bin';
foreach $item (@benchs)
{
	mkdir "./tested-data/";
    foreach $length (@fifo_list)
    {
	foreach $fd (@fdist){
		mkdir "./tested-data/"."$fd/";
		foreach $bf (@buffsize){
		system("rm -rf *.rep");

		copy($input_image, "./images/0.jpg");
		system ("convert ./images/0.jpg -resize 256 ./images/0.bmp");
system("~/CFPU/multi2sim-4.2/bin/m2s --si-sim detailed --si-fifo-length 0 --si-profiling 0 --si-hamming-dist $dist --si-tcam-dist $fd --si-abuff-size $bf  --si-config conf kmeans -i ../../data/kmeans/exp.txt -r -l 1 -m 4 -n 4 > hit.rep");

		
		mkdir "./tested-data/"."$fd/"."$length-$bf";

		$temp = "./tested-data/"."$fd/$length-$bf/"."_$item.rep";
		copy("hit.rep", "$temp");


		system("rm -rf *.rep");
		}		
	}
    }
}
