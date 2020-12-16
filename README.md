# Data 512 Final Project: Measuring political polarization in United States Congressional roll-call votes over the last 2000-2020

# Abstract
Has political polarization spread into the U.S. legislative process? News articles have suggsted that increaseed political polarization could have far-reaching consequences on people's everyday lives on everything from their personal interactions to their physical health ([source](https://greatergood.berkeley.edu/article/item/what_is_the_true_cost_of_polarization_in_america)). While polarization's impact on the legislative process has been cited in articles, such as the [ping-poing effect on energy regulation](https://www.spglobal.com/platts/en/market-insights/latest-news/coal/102320-us-elections-political-polarization-creating-regulatory-ping-pong-effect-for-us-energy), few articles have cited a measurement to evaluate the polarization of the legislative process <i>directly</i>. To address this, this notebook attempts to measure political polarization of both chambers of Congress through the results of their roll-call votes.

# Folder structure & main files
The main files for this project are the following:

| File Name | Summary |
| ------------------ | --------------------- |
| [Report_for_Congressional_Polarization.ipynb](./Report_for_Congressional_Polarization.ipynb) | This Jupyter notebook contains the main analysis and code for this report. Please download and run in Jupyter notebbok for optimal viewing. |
| [full.csv](data/full.csv) | The full cached dataset used in the report to run the analysis. |
| [get_votes.ps1](code/scripts/get_votes.ps1) | The PowerShell script which was used to pull the data from the source APIs. |

# Data
## Cached data
You can run the notebook using the cached dataset from "full.csv"

## How to get the raw data, if you do not wish to use the cached dataset
The original dataset is large, the processed dataset is kept cached in [data/full.csv](data/full.csv) for ease of reproducability.

**WARNING**: in order to make the notebook, [Report_for_Congressional_Polarization.ipynb](./Report_for_Congressional_Polarization.ipynb), use the fresh data in the code as-is you must delete [data/full.csv](data/full.csv) -- if you do not wish to do this please modify the code!

To reproduce the steps to get the original data:
  1. Navigate to a folder where you want to clone the github repo.
  2. Run: git clone "https://github.com/unitedstates/congress.git"
  3. Follow the [setting up instructions](https://github.com/unitedstates/congress.git).
  4. Copy [code/scripts/get_votes.ps1](code/scripts/get_votes.ps1) to the root folder of the congress directory on your computer.
  5. Run get_votes.ps1
  6. Copy the data folder with the output into the data folder of this repository.
  7. Run the [Report_for_Congressional_Polarization.ipynb](./Report_for_Congressional_Polarization.ipynb)
  
**Note:** this may take anywhere bewteeen 5 hours to a few days depending on your internet connection.

### Data quality validation
#### Results of the data quality validation
For the dataset in this analysis the years between 2003-2020 differed by fewer than 2% from the vote counts recorded on the website shared above in "Steps to validate data quality". 

#### Steps to validate data quality
Since the dataset is large and the process to get it is long-running we neded a manner to validate the data quality prior to running our analalysis. We performed the following steps to verify data quality from the long-running download task in "Manual steps to get the dataset":

   1. Navigate to https://www.govtrack.us/congress/votes
   2. Find the "Filter Votes" box and select the year whose vote count you want to verify, as shown below:
   <br/>*Screenshot of the "Filter Votes" box December 6, 2020*
   
   ![Screenshot of the "Filter Votes" box December 6, 2020](pictures/data-verification/filter-votes.png "Filter Votes button")
   
   <br/>
   
   *Screenshot of the "Filter Votes" year selection December 6, 2020*
   
   ![Screenshot of the expanded "Filter Votes" selection box December 6, 2020](pictures/data-verification/filter-votes-expanded-select.png "Filter Votes year selection")
   3. Wait for the page to load, and then take note of the count of votes displayed on the screen, as highlighted, circled and arrowed in the below screenshot.
   <br/>*Screenshot of the vote count (1,035) December 6, 2020*
   ![Screenshot of the vote count December 6, 2020](pictures/data-verification/vote-count.png "Vote count on the screen")
   4. Compare the vote count (e.g., 1,035 in the screenshot above) with the total votes in your downloaded dataset.
   
For convenience, here are the results of carrying out these steps for the years 2003-2020 as of December 6th, 2020 (i.e.: 2020 is incomplete):

*Table: the count of votes in Congress by year according to https://www.govtrack.us/congress/votes*
<br />

| Year | Vote count |
| ---- | ---- |
| 2020 | 488 |
| 2019 | 1129 |
| 2018 | 774 |
| 2017 | 1035 |
| 2016 | 784 |
| 2015 | 1043 |
| 2014 | 929 |
| 2013 | 932 |
| 2012 | 909 |
| 2011 | 1183 |
| 2010 | 963 |
| 2009 | 1388 |
| 2008 | 905 |
| 2007 | 1628 |
| 2006 | 822 |
| 2005 | 1037 |
| 2004 | 760 |
| 2003 | 1136 |

## Data schema
We will use the open-sourced [congress GitHub](https://github.com/unitedstates/congress) set of scrapers to download Congressional roll-call vote data from 2000-2020. More specifically, we'll utilize the [votes data](https://github.com/unitedstates/congress/wiki/votes) which contains data on Congress roll-call votes.

From the project:

> This project collects data on roll call votes, which are the sorts of votes in which the individual positions of legislators is recorded. Other sorts of votes such as unanimous consent requests and voice votes are not collected here.
> 
> Congress publishes roll call vote data in XML starting in 1990 (101st Congress, 2nd session) for the House and 1989 (101st Congress, 1st Session) for the Senate. Senate votes are numbered uniquely by session. Sessions roughly follow calendar years, and there are two sessions per Congress. House vote numbering continues consecutively throughout the Congress.

NOTE: despite what the source says, there were errors getting data before 2000, as such we truncated the dataset for this analysis.

The dataset schema is similar to what follows (maybe updated depending on whether or not I pull in additional data from the scraper):

| Name | Description | Example Value |
| ----- | ----------------------| ------ |
| chamber | Either "h" for House or "s" for Senate | "h" |
| congress | Number of the Congress which carried out this vote | 112 |
| date | The date the roll-call vote happened | "2013-07-18T22:40:39-04:00" |
| number | The number of the vote | 202 |
| session | The year that Congress carried out this vote | 2013 |
| source_url | The source url for the data | "http://clerk.house.gov/evs/2013/roll202.xml"
| updated_at | The date that the data was updated at | "2013-07-18T22:40:39-04:00" |
| vote_id | The vote id of the roll-call vote | "h202-113.2013" |
| category | The type of roll-call vote | "amendment" |
| question | The question that the roll-call vote is on | "On Agreeing to the Amendment: Amendment 24 to H R 2217" |
| type | The type of vote this is | "On the Amendment" |
| requires | The fraction of the vote required to pass | "1/2" |
| result | The result of the roll-call vote | "failed" |
| result_text | The result of the vote (this is just a duplicate field according to the documentation) | "Failed" |
| display_name | Congress person's display name | "John Jay" |
| party | "D" for Democrat, "R" for Republican | "R" |
| state | Two-letter state abbreviation of the state that the congressperson represents | "NC"

# How to run the notebook
You will need a computer with access to the internet in order to download the software required for this notebook.

  1. Install [conda](https://docs.anaconda.com/anaconda/install/)
  2. Open an Anaconda command prompt
  3. Run 
    conda env create -f congress_polarization.yml
  4. Run the following to activate the anaconda environment:
    conda activate congress_polarization
  5. Launch jupyter notebook:
    jupyter notebook
  6. Click on Report_for_Congressional_Polarization.ipynb

# Dependencies used
Here's a list of Python libraries which are used by the notebook:

  1. matplotlib
  2. seaborn
  3. pandas
  4. numpy

# License
This project is under an [MIT License](./LICENSE)