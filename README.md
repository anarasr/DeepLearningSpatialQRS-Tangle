# Deep-Learning-Based Estimation of Spatial QRS-T angle

Welcome to the _DeepLearningSpatialQRS-Tangle_ repository! 🤓

If you're here, you probably saw our open-access research paper: "[**Deep-Learning-Based Estimation of the Spatial QRS-T Angle from Reduced-Lead ECGs**](https://www.mdpi.com/1424-8220/22/14/5414)", published on 20<sup>th</sup> July 2022. In this repository, you'll be able to find **_code_** and any relevant **_documentation_** mentioned in the paper.

**When using this resource, please cite:**

```
  Santos Rodrigues A, Augustauskas R, Lukoševičius M, Laguna P, Marozas V. 
  Deep-Learning-Based Estimation of the Spatial QRS-T Angle from Reduced-Lead ECGs. Sensors. 2022; 22(14):5414. 
  https://doi.org/10.3390/s22145414
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

# Data
## Database
## Training and Validation Datasets
