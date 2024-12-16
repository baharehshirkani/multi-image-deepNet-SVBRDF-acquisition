#!/bin/bash

#SBATCH --job-name=1800_steps_0.0001
#SBATCH --clusters=tinygpu
#SBATCH --nodes=1
#SBATCH --time=24:00:00
#SBATCH --gres=gpu:rtx2080ti:1

module load python/3.8-anaconda

source /home/woody/vlgm/vlgm107v/.bashrc

echo "Activating Conda Environment..."
conda activate myenv-7


echo "Setting variables..."
outputDir="/home/woody/vlgm/vlgm107v/MID/multi-image-deepNet-SVBRDF-acquisition/new_train_1800_lr_0.0001"
inputDir="/home/woody/vlgm/vlgm107v/MID/multi-image-deepNet-SVBRDF-acquisition/dataset/materialsData_multi_image"
max_steps="1800"
loss="mixed"
renderingScene="movingViewHemiSpotLightOneSurface"
checkpoint="/home/adminVDE/trainedModels/trainingOneImage"

echo "Running Python Script..."

python pixes2Material.py --mode train --output_dir $outputDir --input_dir $inputDir --max_steps $max_steps --summary_freq 300 --progress_freq 300 --save_freq 300 --test_freq 300 --batch_size 8 --input_size 512 --nbTargets 4 --loss $loss --useLog --renderingScene $renderingScene --includeDiffuse --which_direction AtoB --lr 0.0001 --inputMode folder --maxImages 5 --feedMethod render --jitterLightPos --jitterViewPos --useCoordConv --useAmbientLight --logOutputAlbedos
#--checkpoint $checkpoint --NoAugmentationInRenderings

echo "Script Completed."
