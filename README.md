# Deep-Learning-Based Estimation of Spatial QRS-T angle

Welcome to the _DeepLearningSpatialQRS-Tangle_ repository! 🤓

If you're here, you probably saw our open-access research paper: "[**Deep-Learning-Based Estimation of the Spatial QRS-T Angle from Reduced-Lead ECGs**](https://www.mdpi.com/1424-8220/22/14/5414)", published on 20<sup>th</sup> July 2022. In this repository, you'll be able to find **_code_** and any relevant **_documentation_** mentioned in the paper.

**When using this resource, please cite:**

```
  Santos Rodrigues A, Augustauskas R, Lukoševičius M, Laguna P, Marozas V. 
  Deep-Learning-Based Estimation of the Spatial QRS-T Angle from Reduced-Lead ECGs. Sensors. 
  2022; 22(14):5414. https://doi.org/10.3390/s22145414
```

**A few important notes before we start:**
- The **_code_** is written in MATLAB and Python. The required versions and toolboxes are specified in each section.
- Some of the **_code_** was implemented by other authors, who are stated/cited accordingly throughout this ```README.md``` and the ```.m``` files. We provide all relevant citations in the ```Refs.bib``` file to simplify referencing and citation.
- The prefix "_fn_" in a filename indicates a MATLAB function (```fnFunctionName.m```). In every function file, you'll find:
  - A _description_ of the function;
  - Any applicable _literature_;
  - Summary of _input/output_ variables;
  - A _list_ of additional ```.m```files. 
  
It looks roughly like this: 
```Matlab 
function [out_A] = fnFunctionName(in_A, in_B)
```
<details>
<summary> <em>Expand here for details</em> </summary>

  ```Matlab
  function [out_A] = fnFunctionName(in_A, in_B)
    %FNFUNCTIONNAME is an example to describe the code syntax used. This is the function description.
      % Any relavant literature is listed as:
      %     [1]: Author 1, Author 2. Title. Journal. Year. DOI.
      %     [2]: Author 1, Author 2. Title. Journal. Year. DOI. 
      %------------------------------------------------------------
      %   INPUTS:
      %------------------------------------------------------------
      %     1) in_A: This is variable of size MxN.
      %     2) in_B: This is another variable.
      %------------------------------------------------------------
      %   OUTPUTS:
      %------------------------------------------------------------
      %     1) out_A: This is variable.
      %------------------------------------------------------------
      %   NECESSARY FUNCTIONS:
      %------------------------------------------------------------
      %     1) fnAnotherFunction.m
      %------------------------------------------------------------
      % Written by: Author (email)
      % Updated: YYYY-MM-DD.
      %------------------------------------------------------------
      % According to [1]:
      out_A = in_A + in_B; 
  end
  ```
</details>



***
## Data
_Physionet's_ [_PTB-XL dataset_](https://www.nature.com/articles/s41597-020-0495-6) is the 12-lead clinical ECG dataset used in our research work. You can download the dataset [here](https://physionet.org/content/ptb-xl/1.0.1/).

**When using this database, please cite:**

  ```
    Wagner, P., Strodthoff, N., Bousseljot, R.-D., Kreiseler, D., Lunze, F.I., Samek, W., Schaeffter, T. (2020), 
    PTB-XL: A Large Publicly Available ECG Dataset. Scientific Data. https://doi.org/10.1038/s41597-020-0495-6
  ```
<details>
  <summary> <em> (and cite this one too) </em> </summary>
  
  ```
    Goldberger, A., Amaral, L., Glass, L., Hausdorff, J., Ivanov, P. C., Mark, R., ... & Stanley, H. E. (2000). 
    PhysioBank, PhysioToolkit, and PhysioNet: Components of a new research resource for complex physiologic signals. 
    Circulation [Online]. 101 (23), pp. e215–e220.
  ```
</details>

***
### Training and Validation Sets
[**Section 4.3.**](https://www.mdpi.com/1424-8220/22/14/5414) of our research paper describes the data splitting process into training and validation datasets. Each dataset is disclosed on the files ```Training_Dataset.csv``` and ```Validation_Dataset.csv``` in the folder ```Split Datasets```. Only the high-quality recordings suitable for analysis (see [Section 4.1.1.](https://www.mdpi.com/1424-8220/22/14/5414)) are listed. In each table, you'll find:

| ecg_id    | patient_id    | sex   | scp_codes     | class   | qrst_angle  | qrst_range  |
|:---       |:---           |:---   |:---           |:---     |:---         |:---         |
|16968	    | 2089          |	1	    | {'NORM': 100.0, 'SR': 0.0}  | ["Norm"]	| 21.081	| [20:25[ |
| ...       | ...           | ...   | ...         | ...           | ...       | ...     | ...     |
| 1427	    | 20044	        | 0	    | {'ASMI': 100.0, 'ISCAL': 100.0, 'SR': 0.0}	|["MI","STTC"]	| 152.1103	| [150:155[ |
| ...       | ...           | ...   | ...         | ...           | ...       | ...     | ...     |

The attributes ***ecg_id***, ***patient_id***, ***sex*** and ***scp_codes*** correspond to the same attributes in the file ```ptbxl_database.csv``` provided by the original documentation of the _PTB-XL_ dataset, whereas ***qrst_angle*** is the estimated QRS-T angle $\alpha$ (°) using the conventional approach and ***qrst_range*** is the range of $\alpha$ = [0:5:180]° as described in the paper. 

You can easily load the `.csv` files in the MATLAB environment with the `readtable` function:
```Matlab
  Train_Data  = readtable("Training_Dataset.csv");
  Val_Data    = readtable("Validation_Dataset.csv");
```

***
### How to read the raw ECG files in MATLAB?
After downloading the raw files from the [_PTB-XL_ dataset page](https://physionet.org/content/ptb-xl/1.0.1/), you can open the ```.dat``` files in MATLAB:
```Matlab
  % Switch the environment/directory
  cd([YOUR_DATA_DIR])
  % Read file
  fid        = fopen([recording_name, '.dat']);
  % Get the raw ECG and convert to volts
  ecg_raw    = transpose(fread(fid, [12 inf], 'int16'))./1000;
  % Close file
  fclose(fid);
  % Get back to working environment
  cd(WORKING_DIR);
```
Alternatively, you can use our function ```fnFileReaderECG.m```. You can also use Physionet's [WFDB Software Package](https://archive.physionet.org/physiotools/wfdb.shtml), but we do **not recommend it** (it is excruciantingly slow).




