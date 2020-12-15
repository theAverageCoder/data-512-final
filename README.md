# Data 512 Final Project: Measuring political polarization in United States Congressional roll-call votes over the last 2000-2020

# Abstract
Has political polarization spread into the U.S. legislative process? News articles have suggsted that increaseed political polarization could have far-reaching consequences on people's everyday lives on everything from their personal interactions to their physical health ([source](https://greatergood.berkeley.edu/article/item/what_is_the_true_cost_of_polarization_in_america)). While polarization's impact on the legislative process has been cited in articles, such as the [ping-poing effect on energy regulation](https://www.spglobal.com/platts/en/market-insights/latest-news/coal/102320-us-elections-political-polarization-creating-regulatory-ping-pong-effect-for-us-energy), few articles have cited a measurement to evaluate the polarization of the legislative process <i>directly</i>. To address this, this notebook attempts to measure political polarization of both chambers of Congress through the results of their roll-call votes.

# Data
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

## Data preparation
I have used  [code/scripts/get_votes.ps1](code/scripts/get_votes.ps1) to download the data for multiple Congresses.

The dataset is rather large and takes an additional Python script to get the data into a dataframe format. It may be reasonable to precompute aggregations (e.g., by year or month) for some portions of the data to be able to visualize and play with it faster.

Futhermore some of the downloaded data appears to have run into errors a few times, so I may need to shorten the length of analysis to simplify dealing with substantial missing values.

# License
This project is under an [MIT License](./LICENSE)