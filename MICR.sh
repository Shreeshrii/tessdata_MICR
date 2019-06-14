#!/bin/bash
#./MICR-input/eng.MICRsymbols.training_text  uses Unicode codepoints
#./MICR-input/eng.MICR.training_text for MICR Encoding font uses A B C D
# eng.mcr.exp0.tif/box based on file by Hunter Beanland (hunter @ beanland.net.au)
# use micr.sed to convert A B C D to use Unicode codepoints

time ~/tesseract/src/training/tesstrain.sh \
  --fonts_dir ~/.fonts \
  --lang eng \
  --langdata_dir ./MICR-input/langdata \
  --tessdata_dir ~/tessdata_best \
  --fontlist \
  "MICR Encoding" \
  --training_text ./MICR-input/langdata/eng/eng.MICR.training_text \
  --workspace_dir ~/tmp \
  --save_box_tiff  \
  --overwrite \
  --output_dir ./MICR-legacy

rm ./MICR-legacy/eng.traineddata
sed -i -f ./MICR-input/micr.sed ./MICR-legacy/eng.MICR_Encoding.exp0.box
mv ./MICR-legacy/eng.MICR_Encoding.exp0.box ./MICR-input/
mv ./MICR-legacy/eng.MICR_Encoding.exp0.tif ./MICR-input/

time ~/tesseract/src/training/tesstrain.sh \
  --fonts_dir ~/.fonts \
  --lang eng \
  --langdata_dir ./MICR-input/langdata \
  --tessdata_dir ~/tessdata_best \
  --fontlist \
  "Arial Unicode MS" \
  --training_text ./MICR-input/langdata/eng/eng.MICRsymbols.training_text \
  --workspace_dir ~/tmp \
  --my_boxtiff_dir ./MICR-input \
  --save_box_tiff  \
  --overwrite \
  --output_dir ./MICR-legacy

mv ./MICR-legacy/eng.traineddata ./MICR-legacy/MICR.traineddata
mv ./MICR-legacy/eng.*.box ./MICR-input/
mv ./MICR-legacy/eng.*.tif ./MICR-input/

tesseract ./MICR-input/test/MICR-test.png  ./MICR-input/test/MICR-test -l MICR --tessdata-dir ./MICR-legacy  -c page_separator="" 
diff ./MICR-input/test/MICR-test.txt ./MICR-input/test/MICR-test.gt.txt 
