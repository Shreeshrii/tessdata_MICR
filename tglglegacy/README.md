## Training for base/legacy tesseract

```
 bash ~/tesseract/src/training/tesstrain.sh \
 --fonts_dir ~/.fonts \
 --lang eng \
 --langdata_dir ~/langdata_lstm \
 --tessdata_dir ~/tessdata_best  \
 --workspace_dir ~/tmp \
 --fontlist \
 "Quivira" \
 "Noto Sans Tagalog" \
 "Tagalog Doctrina 1593" \
 "Baybayin Lopez" \
 "Bisaya Hervas Italic" \
 "Bikol Mintz" \
 "Tagalog Stylized" \
 --training_text tglg.legacy.training_text \
 --exposures "0" \
  --maxpages 0 \
 --output_dir ./
 ```
