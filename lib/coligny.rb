# Copyright 2017 @shanekrusen 
# License MIT (https://opensource.org/licenses/MIT)

require "coligny/version"

module Coligny
  require 'date'
  
  metonic_notations = { "Samonios 1 1" => ["N DUMANNI IVOS"], 
                        "Samonios 2 1" => ["ITI MD", "IVOS"], 
                        "Samonios 3 1" => ["TII D DUM ALE", "IVOS"], 
                        "Samonios 4 1" => "MD", 
                        "Samonios 5 1" => "D AMB", 
                        "Samonios 6 1" => "MD",
                        "Samonios 7 1" => "PRINI LOUDIN",
                        "Samonios 8 1" => "D DUMANI",
                        "Samonios 9 1" => "IIT MD",
                        "Samonios 10 1" => "MD",
                        "Samonios 11 1" => "D AMB",
                        "Samonios 12 1" => "MD",
                        "Samonios 13 1" => "TII MD",
                        "Samonios 14 1" => "ITI MD",
                        "Samonios 15 1" => "IIT MD",
                        "Samonios 16 1" => "D DUMANNI",
                        "Samonios 17 1" => "IIT MD TRINUX SAM",
                        "Samonios 18 1" => "D AMB",
                        "Samonios 19 1" => "TII MD",
                        "Samonios 20 1" => "ITI D AMB",
                        "Samonios 21 1" => "IIT MD",
                        "Samonios 22 1" => "D AMB",
                        "Samonios 23 1" => "N INIS R",
                        "Samonios 24 1" => "N INIS R",
                        "Samonios 25 1" => "TII MD",
                        "Samonios 26 1" => ["ITI D AMB", "IVOS"],
                        "Samonios 27 1" => ["IIT MD", "IVOS"],
                        "Samonios 28 1" => ["D AMB", "IVOS"],
                        "Samonios 29 1" => ["MD", "IVOS"],
                        "Samonios 30 1" => ["D AMB", "IVOS"],
                        "Dumanios 1 1" => ["SAM PRINI LOUD EXO", "IVOS"],
                        "Dumanios 2 1" => ["N", "IVOS"],
                        "Dumanios 3 1" => ["D", "IVOS"],
                        "Dumanios 4 1" => ["D", "IVOS"],
                        "Dumanios 5 1" => "PRINI LAGET",
                        "Dumanios 6 1" => "D",
                        "Dumanios 7 1" => "N INIS R",
                        "Dumanios 8 1" => "ITI MD SAMONI",
                        "Dumanios 9 1" => "D",
                        "Dumanios 10 1" => "D",
                        "Dumanios 11 1" => "N INIS R",
                        "Dumanios 12 1" => "D",
                        "Dumanios 13 1" => "D",
                        "Dumanios 14 1" => "D",
                        "Dumanios 15 1" => "D",
                        "Dumanios 16 1" => "MD SAMONI",
                        "Dumanios 17 1" => "MD SAMONI",
                        "Dumanios 18 1" => "ITI D AMB",
                        "Dumanios 19 1" => "IIT D",
                        "Dumanios 20 1" => "D AMB",
                        "Dumanios 21 1" => "IIT M D",
                        "Dumanios 22 1" => "D AMB",
                        "Dumanios 23 1" => "TII D",
                        "Dumanios 24 1" => "N INIS R",
                        "Dumanios 25 1" => "IIT D",
                        "Dumanios 26 1" => "D AMB",
                        "Dumanios 27 1" => "N INIS R",
                        "Dumanios 28 1" => "D AMB",
                        "Dumanios 29 1" => "NSDS",
                        "Riuros 1 1" => "D ANAGANT",
                        "Riuros 2 1" => "PRINI LOUD",
                        "Riuros 3 1" => "N",
                        "Riuros 4 1" => "(MD) BRIGIOMU RIVRI",
                        "Riuros 5 1" => "N INIS R",
                        "Riuros 6 1" => "MD",
                        "Riuros 7 1" => "MD",
                        "Riuros 8 1" => "PRINI LOUD",
                        "Riuros 9 1" => "ITI MD",
                        "Riuros 10 1" => "IIT MD",
                        "Riuros 11 1" => "N INIS R",
                        "Riuros 12 1" => "MD",
                        "Riuros 13 1" => "DEC/VOR LUG RIV",
                        "Riuros 14 1" => ["NSDS", "IVOS"],
                        "Riuros 15 1" => ["DSNS", "IVOS"],
                        "Riuros 16 1" => ["MD", "IVOS"],
                        "Riuros 17 1" => ["MD", "IVOS"],
                        "Riuros 18 1" => ["D AMB", "IVOS"],
                        "Riuros 19 1" => ["MD", "IVOS"],
                        "Riuros 20 1" => ["TII D AMB", "IVOS"],
                        "Riuros 21 1" => "ITT MD",
                        "Riuros 22 1" => "IIT D AMB",
                        "Riuros 23 1" => "D PETIUX ANAG",
                        "Riuros 24 1" => "D AMB",
                        "Riuros 25 1" => "IIT MD PETIUX RIVRI",
                        "Riuros 26 1" => ["TII D AMB", "IVOS"],
                        "Riuros 27 1" => ["ITI MD", "IVOS"],
                        "Riuros 28 1" => ["IIT D AMB", "IVOS"],
                        "Riuros 29 1" => ["MD", "IVOS"],
                        "Riuros 30 1" => ["D AMB", "IVOS"],
                        "Anagantios 1 1" => ["MD RIVRI IX", "IVOS"],
                        "Anagantios 2 1" => ["D", "IVOS"],
                        "Anagantios 3 1" => ["D", "IVOS"],
                        "Anagantios 4 1" => "N OGIOUMU RIVRI",
                        "Anagantios 5 1" => "N INIS R",
                        "Anagantios 6 1" => "PRINI LAG",
                        "Anagantios 7 1" => "D",
                        "Anagantios 8 1" => "D",
                        "Anagantios 9 1" => "D",
                        "Anagantios 10 1" => "D",
                        "Anagantios 11 1" => "D AMB",
                        "Anagantios 12 1" => "D",
                        "Anagantios 13 1" => "D",
                        "Anagantios 14 1" => "D",
                        "Anagantios 15 1" => "D",
                        "Anagantios 16 1" => "D",
                        "Anagantios 17 1" => "D",
                        "Anagantios 18 1" => "TII D AMB",
                        "Anagantios 19 1" => "ITI D",
                        "Anagantios 20 1" => "IIT D AMB",
                        "Anagantios 21 1" => "N INIS R",
                        "Anagantios 22 1" => "N INIS R",
                        "Anagantios 23 1" => "D",
                        "Anagantios 24 1" => "N INIS R",
                        "Anagantios 25 1" => "ITI D",
                        "Anagantios 26 1" => "IIT D AMB",
                        "Anagantios 27 1" => "D",
                        "Anagantios 28 1" => "D AMB",
                        "Anagantios 29 1" => "D",
                        "Ogronios 1 1" => "MD",
                        "Ogronios 2 1" => "MD",
                        "Ogronios 3 1" => "PRINI LOUD",
                        "Ogronios 4 1" => "ITI MD",
                        "Ogronios 5 1" => "N INIS R",
                        "Ogronios 6 1" => "MD",
                        "Ogronios 7 1" => "MD",
                        "Ogronios 8 1" => "MD",
                        "Ogronios 9 1" => "TII MD",
                        "Ogronios 10 1" => "ITI MD",
                        "Ogronios 11 1" => "IIT D AMB",
                        "Ogronios 12 1" => "MD",
                        "Ogronios 13 1" => "MD",
                        "Ogronios 14 1" => "MD",
                        "Ogronios 15 1" => "N",
                        "Ogronios 16 1" => "TII MD CVTI",
                        "Ogronios 17 1" => "ITI MD CVTI",
                        "Ogronios 18 1" => "IIT D CVTI AMB",
                        "Ogronios 19 1" => "MD",
                        "Ogronios 20 1" => "D AMB",
                        "Ogronios 21 1" => "TIT MD",
                        "Ogronios 22 1" => "ITI D AMB",
                        "Ogronios 23 1" => "ITI MD QVTI",
                        "Ogronios 24 1" => "D AMB",
                        "Ogronios 25 1" => "MD",
                        "Ogronios 26 1" => "D AMB",
                        "Ogronios 27 1" => "N INIS R",
                        "Ogronios 28 1" => "ITI D AMB",
                        "Ogronios 29 1" => "IIT MD",
                        "Ogronios 30 1" => "D AMB",
                        "Cutios 1 1" => "MD",
                        "Cutios 2 1" => "MD",
                        "Cutios 3 1" => "MD",
                        "Cutios 4 1" => "PRINI LOUD",
                        "Cutios 5 1" => "N INIS R",
                        "Cutios 6 1" => "N",
                        "Cutios 7 1" => "MD",
                        "Cutios 8 1" => "MD",
                        "Cutios 9 1" => "N INIS R",
                        "Cutios 10 1" => "TII MD",
                        "Cutios 11 1" => "ITI D AMB",
                        "Cutios 12 1" => "IIT MD",
                        "Cutios 13 1" => "MD",
                        "Cutios 14 1" => "MD",
                        "Cutios 15 1" => "MD",
                        "Cutios 16 1" => "MD OGRON",
                        "Cutios 17 1" => "MD OGRON",
                        "Cutios 18 1" => "D OGRON AMB",
                        "Cutios 19 1" => "N INIS R",
                        "Cutios 20 1" => "D AMB",
                        "Cutios 21 1" => "N INIS R",
                        "Cutios 22 1" => "TII D AMB",
                        "Cutios 23 1" => "IIT MD OGRONI",
                        "Cutios 24 1" => "IIT D AMB",
                        "Cutios 25 1" => "MD",
                        "Cutios 26 1" => "D AMB",
                        "Cutios 27 1" => "MD",
                        "Cutios 28 1" => ["TII D AMB", "IVOS"],
                        "Cutios 29 1" => ["ITI MD", "IVOS"],
                        "Cutios 30 1" => ["IIT D AMB", "IVOS"],
                        "Giamonios 1 1" => ["MD SIMUISONNA EXO", "IVOS"],
                        "Giamonios 2 1" => ["D", "IVOS"],
                        "Giamonios 3 1" => ["D", "IVOS"],
                        "Giamonios 4 1" => "D",
                        "Giamonios 5 1" => "D AMB",
                        "Giamonios 6 1" => "D",
                        "Giamonios 7 1" => "N PRINI LAG",
                        "Giamonios 8 1" => "D",
                        "Giamonios 9 1" => "N INIS R",
                        "Giamonios 10 1" => "D",
                        "Giamonios 11 1" => "D AMB",
                        "Giamonios 12 1" => "D",
                        "Giamonios 13 1" => "TII D",
                        "Giamonios 14 1" => "ITI D",
                        "Giamonios 15 1" => "IIT D",
                        "Giamonios 16 1" => "D",
                        "Giamonios 17 1" => "NSDS",
                        "Giamonios 18 1" => "D AMB",
                        "Giamonios 19 1" => "TII D",
                        "Giamonios 20 1" => "ITI D AMB",
                        "Giamonios 21 1" => "IIT D",
                        "Giamonios 22 1" => "N INIS R",
                        "Giamonios 23 1" => "N INIS R",
                        "Giamonios 24 1" => "D AMB",
                        "Giamonios 25 1" => "TII D",
                        "Giamonios 26 1" => "N INIS R",
                        "Giamonios 27 1" => "IIT D",
                        "Giamonios 28 1" => "D AMB",
                        "Giamonios 29 1" => "D",
                        "Simiuisonna 1 1" => "GIAM PRINI LAG",
                        "Simiuisonna 2 1" => "MD",
                        "Simiuisonna 3 1" => "D EQVI",
                        "Simiuisonna 4 1" => "MD",
                        "Simiuisonna 5 1" => "N INIS R",
                        "Simiuisonna 6 1" => "D EQVI",
                        "Simiuisonna 7 1" => "IIT MD TIOCOBREXTIO",
                        "Simiuisonna 8 1" => "N",
                        "Simiuisonna 9 1" => "MD SINDIU IVOS",
                        "Simiuisonna 10 1" => "MD",
                        "Simiuisonna 11 1" => "TII D AMB",
                        "Simiuisonna 12 1" => "ITI MD",
                        "Simiuisonna 13 1" => "D EQVI",
                        "Simiuisonna 14 1" => "D EQVI",
                        "Simiuisonna 15 1" => "D EQVI",
                        "Simiuisonna 16 1" => "D EQVI",
                        "Simiuisonna 17 1" => "D EQVI",
                        "Simiuisonna 18 1" => "D AMB EQVI",
                        "Simiuisonna 19 1" => "IIT MD",
                        "Simiuisonna 20 1" => "D AMB",
                        "Simiuisonna 21 1" => "IIT D EQVI",
                        "Simiuisonna 22 1" => "D AMB",
                        "Simiuisonna 23 1" => "TII MD",
                        "Simiuisonna 24 1" => "ITI D AMB",
                        "Simiuisonna 25 1" => "IIT MD",
                        "Simiuisonna 26 1" => "D AMB",
                        "Simiuisonna 27 1" => "MD",
                        "Simiuisonna 28 1" => "D AMB",
                        "Simiuisonna 29 1" => "NSDS (AMB)",
                        "Simiuisonna 30 1" => "DSNS AMB",
                        "Equos 1 1" => "D",
                        "Equos 2 1" => "PRINI LAG",
                        "Equos 3 1" => "MD SINIVIS",
                        "Equos 4 1" => "D",
                        "Equos 5 1" => "D AMB",
                        "Equos 6 1" => "ITI MD SIMIVISO",
                        "Equos 7 1" => "D",
                        "Equos 8 1" => "PRINI LAG",
                        "Equos 9 1" => "N",
                        "Equos 10 1" => "D",
                        "Equos 11 1" => "D AMB",
                        "Equos 12 1" => "D",
                        "Equos 13 1" => "IIT MD SIMI",
                        "Equos 14 1" => "MD SIMI",
                        "Equos 15 1" => "MD SIMI",
                        "Equos 16 1" => "MD SIMIVIS",
                        "Equos 17 1" => "TII MD SIMIVIS",
                        "Equos 18 1" => "ITI D AMB SIMIVIS",
                        "Equos 19 1" => "D",
                        "Equos 20 1" => "TII D AMB",
                        "Equos 21 1" => "IIT (M)D SIMIVIS",
                        "Equos 22 1" => "D AMB",
                        "Equos 23 1" => "D",
                        "Equos 24 1" => "D AMB",
                        "Equos 25 1" => "D",
                        "Equos 26 1" => ["TII D AMB", "IVOS"],
                        "Equos 27 1" => ["ITI D", "IVOS"],
                        "Equos 28 1" => ["IIT D AMB", "IVOS"],
                        "Equos 29 1" => ["D", "IVOS"],
                        "Elembi 1 1" => ["D", "IVOS"],
                        "Elembi 2 1" => ["D", "IVOS"],
                        "Elembi 3 1" => ["PRINI LAG", "IVOS"],
                        "Elembi 4 1" => ["D", "IVOS"],
                        "Elembi 5 1" => "D AMB",
                        "Elembi 6 1" => "D",
                        "Elembi 7 1" => "D",
                        "Elembi 8 1" => "D",
                        "Elembi 9 1" => "PRINI LAG",
                        "Elembi 10 1" => "N INIS R",
                        "Elembi 11 1" => "D AMB",
                        "Elembi 12 1" => "D",
                        "Elembi 13 1" => "D",
                        "Elembi 14 1" => "D",
                        "Elembi 15 1" => "(N)",
                        "Elembi 16 1" => "MD EDRIN",
                        "Elembi 17 1" => "MD EDRIN",
                        "Elembi 18 1" => "TII D EDRIN AMB",
                        "Elembi 19 1" => "D",
                        "Elembi 20 1" => "D AMB",
                        "Elembi 21 1" => "IIT D",
                        "Elembi 22 1" => "D AMB",
                        "Elembi 23 1" => "D",
                        "Elembi 24 1" => "D AMB",
                        "Elembi 25 1" => "D",
                        "Elembi 26 1" => "D AMB",
                        "Elembi 27 1" => "TII D",
                        "Elembi 28 1" => "ITI D AMB",
                        "Elembi 29 1" => "IIT D",
                        "Aedrinni 1 1" => ["D CANTLI", "IVOS"],
                        "Aedrinni 2 1" => ["MD", "IVOS"],
                        "Aedrinni 3 1" => ["MD", "IVOS"],
                        "Aedrinni 4 1" => "MD",
                        "Aedrinni 5 1" => "D AMB",
                        "Aedrinni 6 1" => "PRINI LOUD",
                        "Aedrinni 7 1" => "ITI MD [TIOGBR?]",
                        "Aedrinni 8 1" => "IIT MD TIOCOBREXTIO",
                        "Aedrinni 9 1" => "MD",
                        "Aedrinni 10 1" => "MD",
                        "Aedrinni 11 1" => "N",
                        "Aedrinni 12 1" => "TII MD",
                        "Aedrinni 13 1" => "ITI MD",
                        "Aedrinni 14 1" => "IIT MD",
                        "Aedrinni 15 1" => "MD",
                        "Aedrinni 16 1" => "D ELEMB",
                        "Aedrinni 17 1" => "D ELEMB",
                        "Aedrinni 18 1" => "D ELEMB AMB",
                        "Aedrinni 19 1" => "ITI MD",
                        "Aedrinni 20 1" => "IIT D AMB",
                        "Aedrinni 21 1" => "IIT MD",
                        "Aedrinni 22 1" => "D AMB",
                        "Aedrinni 23 1" => "MD",
                        "Aedrinni 24 1" => "TII D AMB",
                        "Aedrinni 25 1" => ["ITI D SINDIV", "IVOS"],
                        "Aedrinni 26 1" => "IIT D AMB",
                        "Aedrinni 27 1" => "MD",
                        "Aedrinni 28 1" => "D AMB",
                        "Aedrinni 29 1" => "MD",
                        "Aedrinni 30 1" => "N",
                        "Cantlos 1 1" => "MD AEDRIN",
                        "Cantlos 2 1" => "D",
                        "Cantlos 3 1" => "D",
                        "Cantlos 4 1" => "PRINI LAG",
                        "Cantlos 5 1" => "D AMB",
                        "Cantlos 6 1" => "D",
                        "Cantlos 7 1" => "D",
                        "Cantlos 8 1" => "D",
                        "Cantlos 9 1" => "D",
                        "Cantlos 10 1" => "D",
                        "Cantlos 11 1" => "D AMB",
                        "Cantlos 12 1" => "N",
                        "Cantlos 13 1" => "D",
                        "Cantlos 14 1" => "D",
                        "Cantlos 15 1" => "D TIOCOBREXTIO",
                        "Cantlos 16 1" => "D",
                        "Cantlos 17 1" => "D",
                        "Cantlos 18 1" => "D AMB",
                        "Cantlos 19 1" => "N INIS R",
                        "Cantlos 20 1" => "D AMB",
                        "Cantlos 21 1" => "IIT D",
                        "Cantlos 22 1" => "D AMB",
                        "Cantlos 23 1" => "D",
                        "Cantlos 24 1" => "D AMB",
                        "Cantlos 25 1" => "D",
                        "Cantlos 26 1" => "D AMB",
                        "Cantlos 27 1" => "D",
                        "Cantlos 28 1" => ["TII D AMB", "IVOS"],
                        "Cantlos 29 1" => ["ITI D", "IVOS"],
                        "Samonios 1 2" => ["N DUMANNI", "IVOS"],
                        "Samonios 2 2" => ["ITI MD", "IVOS"],
                        "Samonios 3 2" => ["TII D DUM ALE", "IVOS"],
                        "Samonios 4 2" => "MD",
                        "Samonios 5 2" => "D AMB",
                        "Samonios 6 2" => "MD",
                        "Samonios 7 2" => "PRINI LOUDIN",
                        "Samonios 8 2" => "D DUMANI",
                        "Samonios 9 2" => "IIT MD",
                        "Samonios 10 2" => "MD",
                        "Samonios 11 2" => "D AMB",
                        "Samonios 12 2" => "MD",
                        "Samonios 13 2" => "N",
                        "Samonios 14 2" => "ITI MD",
                        "Samonios 15 2" => "IIT MD",
                        "Samonios 16 2" => "D DUMANNI",
                        "Samonios 17 2" => "IIT MD TRINUX SAM",
                        "Samonios 18 2" => "D AMB",
                        "Samonios 19 2" => "TII MD",
                        "Samonios 20 2" => "ITI D AMB",
                        "Samonios 21 2" => "IIT MD",
                        "Samonios 22 2" => "D AMB",
                        "Samonios 23 2" => "N INIS R",
                        "Samonios 24 2" => "N INIS R",
                        "Samonios 25 2" => "TII MD",
                        "Samonios 26 2" => ["ITI D AMB", "IVOS"],
                        "Samonios 27 2" => ["IIT MD", "IVOS"],
                        "Samonios 28 2" => ["D AMB", "IVOS"],
                        "Samonios 29 2" => ["MD", "IVOS"],
                        "Samonios 30 2" => ["D AMB", "IVOS"],
                        "Dumanios 1 2" => ["SAM PRINI LOUD EXO", "IVOS"],
                        "Dumanios 2 2" => ["N", "IVOS"],
                        "Dumanios 3 2" => ["D", "IVOS"],
                        "Dumanios 4 2" => ["D", "IVOS"],
                        "Dumanios 5 2" => "PRINI LAGET",
                        "Dumanios 6 2" => "D",
                        "Dumanios 7 2" => "N INIS R",
                        "Dumanios 8 2" => "ITI MD SAMONI",
                        "Dumanios 9 2" => "D",
                        "Dumanios 10 2" => "D",
                        "Dumanios 11 2" => "N INIS R",
                        "Dumanios 12 2" => "D",
                        "Dumanios 13 2" => "D",
                        "Dumanios 14 2" => "N",
                        "Dumanios 15 2" => "D",
                        "Dumanios 16 2" => "MD SAMONI",
                        "Dumanios 17 2" => "MD SAMONI",
                        "Dumanios 18 2" => "D AMB",
                        "Dumanios 19 2" => "D",
                        "Dumanios 20 2" => "D AMB",
                        "Dumanios 21 2" => "IIT D",
                        "Dumanios 22 2" => "D AMB",
                        "Dumanios 23 2" => "D",
                        "Dumanios 24 2" => "N INIS R",
                        "Dumanios 25 2" => "D",
                        "Dumanios 26 2" => "D AMB (N AMB)",
                        "Dumanios 27 2" => "N INIS R",
                        "Dumanios 28 2" => "D AMB",
                        "Dumanios 29 2" => "D",
                        "Riuros 1 2" => "D ANAGANT",
                        "Riuros 2 2" => "PRINI LOUD",
                        "Riuros 3 2" => "N",
                        "Riuros 4 2" => "(MD) BRIGIOMU RIVRI",
                        "Riuros 5 2" => "N INIS R",
                        "Riuros 6 2" => "MD",
                        "Riuros 7 2" => "MD",
                        "Riuros 8 2" => "PRINI LOUD",
                        "Riuros 9 2" => "ITI MD",
                        "Riuros 10 2" => "IIT MD",
                        "Riuros 11 2" => "N INIS R",
                        "Riuros 12 2" => "MD",
                        "Riuros 13 2" => "DEC/VOR LUG RIV",
                        "Riuros 14 2" => ["NSDS", "IVOS"],
                        "Riuros 15 2" => ["N", "IVOS"],
                        "Riuros 16 2" => ["MD", "IVOS"],
                        "Riuros 17 2" => ["MD", "IVOS"],
                        "Riuros 18 2" => ["D AMB", "IVOS"],
                        "Riuros 19 2" => ["MD", "IVOS"],
                        "Riuros 20 2" => ["TII D AMB", "IVOS"],
                        "Riuros 21 2" => "ITT MD",
                        "Riuros 22 2" => "IIT D AMB",
                        "Riuros 23 2" => "D PETIUX ANAG",
                        "Riuros 24 2" => "N",
                        "Riuros 25 2" => "IIT MD PETIUX RIVRI",
                        "Riuros 26 2" => ["TII D AMB", "IVOS"],
                        "Riuros 27 2" => ["ITI MD", "IVOS"],
                        "Riuros 28 2" => ["IIT D AMB", "IVOS"],
                        "Riuros 29 2" => ["MD", "IVOS"],
                        "Riuros 30 2" => ["D AMB", "IVOS"],
                        "Anagantios 1 2" => ["MD RIVRI IX", "IVOS"],
                        "Anagantios 2 2" => ["D", "IVOS"],
                        "Anagantios 3 2" => ["D", "IVOS"],
                        "Anagantios 4 2" => "N OGIOUMU RIVRI",
                        "Anagantios 5 2" => "N INIS R",
                        "Anagantios 6 2" => "PRINI LAG",
                        "Anagantios 7 2" => "NSDS",
                        "Anagantios 8 2" => "D",
                        "Anagantios 9 2" => "D",
                        "Anagantios 10 2" => "D",
                        "Anagantios 11 2" => "D AMB",
                        "Anagantios 12 2" => "D",
                        "Anagantios 13 2" => "D",
                        "Anagantios 14 2" => "D",
                        "Anagantios 15 2" => "D",
                        "Anagantios 16 2" => "N",
                        "Anagantios 17 2" => "D",
                        "Anagantios 18 2" => "D AMB",
                        "Anagantios 19 2" => "D",
                        "Anagantios 20 2" => "D AMB",
                        "Anagantios 21 2" => "N INIS R",
                        "Anagantios 22 2" => "N INIS R",
                        "Anagantios 23 2" => "D",
                        "Anagantios 24 2" => "N INIS R",
                        "Anagantios 25 2" => "D",
                        "Anagantios 26 2" => "D AMB",
                        "Anagantios 27 2" => "D",
                        "Anagantios 28 2" => "D AMB",
                        "Anagantios 29 2" => "D",
                        "Ogronios 1 2" => "MD",
                        "Ogronios 2 2" => "MD",
                        "Ogronios 3 2" => "PRINI LOUD",
                        "Ogronios 4 2" => "ITI MD",
                        "Ogronios 5 2" => "N INIS R",
                        "Ogronios 6 2" => "MD",
                        "Ogronios 7 2" => "MD",
                        "Ogronios 8 2" => "MD",
                        "Ogronios 9 2" => "TII MD",
                        "Ogronios 10 2" => "ITI MD",
                        "Ogronios 11 2" => "IIT D AMB",
                        "Ogronios 12 2" => "MD",
                        "Ogronios 13 2" => "MD",
                        "Ogronios 14 2" => "MD",
                        "Ogronios 15 2" => "N",
                        "Ogronios 16 2" => "TII MD CVTI",
                        "Ogronios 17 2" => "N CVTI",
                        "Ogronios 18 2" => "IIT D CVTI AMB",
                        "Ogronios 19 2" => "MD",
                        "Ogronios 20 2" => "D AMB",
                        "Ogronios 21 2" => "TIT MD",
                        "Ogronios 22 2" => "ITI D AMB",
                        "Ogronios 23 2" => "ITI MD QVTI",
                        "Ogronios 24 2" => "D AMB",
                        "Ogronios 25 2" => "MD",
                        "Ogronios 26 2" => "D AMB",
                        "Ogronios 27 2" => "N INIS R",
                        "Ogronios 28 2" => "ITI D AMB",
                        "Ogronios 29 2" => "IIT MD",
                        "Ogronios 30 2" => "D AMB",
                        "Cutios 1 2" => "MD",
                        "Cutios 2 2" => "MD",
                        "Cutios 3 2" => "MD",
                        "Cutios 4 2" => "PRINI LOUD",
                        "Cutios 5 2" => "N INIS R",
                        "Cutios 6 2" => "N",
                        "Cutios 7 2" => "MD",
                        "Cutios 8 2" => "MD",
                        "Cutios 9 2" => "N INIS R",
                        "Cutios 10 2" => "TII MD",
                        "Cutios 11 2" => "ITI D AMB",
                        "Cutios 12 2" => "IIT MD",
                        "Cutios 13 2" => "MD",
                        "Cutios 14 2" => "MD",
                        "Cutios 15 2" => "MD",
                        "Cutios 16 2" => "MD OGRON",
                        "Cutios 17 2" => "MD OGRON",
                        "Cutios 18 2" => "N OGRON",
                        "Cutios 19 2" => "N INIS R",
                        "Cutios 20 2" => "D AMB",
                        "Cutios 21 2" => "N INIS R",
                        "Cutios 22 2" => "TII D AMB",
                        "Cutios 23 2" => "IIT MD OGRONI",
                        "Cutios 24 2" => "IIT D AMB",
                        "Cutios 25 2" => "MD",
                        "Cutios 26 2" => "D AMB",
                        "Cutios 27 2" => "MD",
                        "Cutios 28 2" => ["TII D AMB", "IVOS"],
                        "Cutios 29 2" => ["ITI MD", "IVOS"],
                        "Cutios 30 2" => ["IIT D AMB", "IVOS"],
                        "Rantaranos 1 2" => ["D SAMON DUMAN", "IVOS"],
                        "Rantaranos 2 2" => ["D DUMANI", "IVOS"],
                        "Rantaranos 3 2" => ["(ITI) MD RIVRI", "IVOS"],
                        "Rantaranos 4 2" => "MD OCIOMV RIVRI AN\n--]T ANAG",
                        "Rantaranos 5 2" => "N OGRON\nINNIS R",
                        "Rantaranos 6 2" => "(IIT) MD CUTI",
                        "Rantaranos 7 2" => "GIAMON PRINI LAG\n[---\n[---",
                        "Rantaranos 8 2" => "D GIAM SIMVIS",
                        "Rantaranos 9 2" => "N GIAMO EQVI\nINNIS R",
                        "Rantaranos 10 2" => "N ELEMB INIS R",
                        "Rantaranos 11 2" => "D EDRINI AMB",
                        "Rantaranos 12 2" => "IIT D CANTLI",
                        "Rantaranos 13 2" => "TII MD SAMONI",
                        "Rantaranos 14 2" => "D DUMANNI",
                        "Rantaranos 15 2" => "DS MS NS RIVR",
                        "Rantaranos 16 2" => "D ANAGAN",
                        "Rantaranos 17 2" => "ITI MD QVTI OGRON",
                        "Rantaranos 18 2" => "D OGRONI QVT (AMB)",
                        "Rantaranos 19 2" => "D GIAMONI",
                        "Rantaranos 20 2" => "D SIMIS AMB",
                        "Rantaranos 21 2" => "IIT D SIMIS EQUI",
                        "Rantaranos 22 2" => "N GIAMONI\nELEMBI",
                        "Rantaranos 23 2" => "N GIAMONI\nAEDRINNI",
                        "Rantaranos 24 2" => "D GIAMO CANT\nAMB RIXR",
                        "Rantaranos 25 2" => "TII MD SAMON",
                        "Rantaranos 26 2" => "D DUMAN AMB",
                        "Rantaranos 27 2" => "ITI MD RIVRI",
                        "Rantaranos 28 2" => "D ANAG AMB",
                        "Rantaranos 29 2" => "IIT D M OGRONV",
                        "Rantaranos 30 2" => "IIT D AMB QVT",
                        "Giamonios 1 2" => "MD SIMUISONNA",
                        "Giamonios 2 2" => "D",
                        "Giamonios 3 2" => "D",
                        "Giamonios 4 2" => "D",
                        "Giamonios 5 2" => "D AMB",
                        "Giamonios 6 2" => "D",
                        "Giamonios 7 2" => "IIT MD SIMIU TIOCOBREXTIO",
                        "Giamonios 8 2" => "MD SIMIUSONNA",
                        "Giamonios 9 2" => ["MD SIMIU SINDIU", "IVOS"],
                        "Giamonios 10 2" => "D",
                        "Giamonios 11 2" => "D AMB",
                        "Giamonios 12 2" => "D",
                        "Giamonios 13 2" => "D",
                        "Giamonios 14 2" => "D",
                        "Giamonios 15 2" => "D",
                        "Giamonios 16 2" => "D",
                        "Giamonios 17 2" => "NSDS",
                        "Giamonios 18 2" => "D AMB",
                        "Giamonios 19 2" => "D",
                        "Giamonios 20 2" => "D AMB",
                        "Giamonios 21 2" => "IIT D",
                        "Giamonios 22 2" => "D SIMIUI AMB",
                        "Giamonios 23 2" => "TII MD SIMIUISONNA",
                        "Giamonios 24 2" => "ITI D SIMIUIS AMB",
                        "Giamonios 25 2" => "D",
                        "Giamonios 26 2" => "N INIS R",
                        "Giamonios 27 2" => "D",
                        "Giamonios 28 2" => "D AMB",
                        "Giamonios 29 2" => "D",
                        "Simiuisonna 1 2" => "GIAM PRINI LAG",
                        "Simiuisonna 2 2" => "MD",
                        "Simiuisonna 3 2" => "D EQVI",
                        "Simiuisonna 4 2" => "MD",
                        "Simiuisonna 5 2" => "N INIS R",
                        "Simiuisonna 6 2" => "D EQVI",
                        "Simiuisonna 7 2" => "D EQVI",
                        "Simiuisonna 8 2" => "PRINI LAG EQVI",
                        "Simiuisonna 9 2" => "D EQVI",
                        "Simiuisonna 10 2" => "MD",
                        "Simiuisonna 11 2" => "TII D AMB",
                        "Simiuisonna 12 2" => "ITI MD",
                        "Simiuisonna 13 2" => "D EQVI",
                        "Simiuisonna 14 2" => "NSDS EQVI",
                        "Simiuisonna 15 2" => "DSNS EQVI",
                        "Simiuisonna 16 2" => "D EQVI",
                        "Simiuisonna 17 2" => "D EQVI",
                        "Simiuisonna 18 2" => "D EQVI AMB",
                        "Simiuisonna 19 2" => "IIT MD",
                        "Simiuisonna 20 2" => "D AMB",
                        "Simiuisonna 21 2" => "ITT D EQVI",
                        "Simiuisonna 22 2" => "D EQVI AMB",
                        "Simiuisonna 23 2" => "D EQVI",
                        "Simiuisonna 24 2" => "D AMB EQVI",
                        "Simiuisonna 25 2" => "IIT MD",
                        "Simiuisonna 26 2" => ["D AMB", "IVOS"],
                        "Simiuisonna 27 2" => ["MD", "IVOS"],
                        "Simiuisonna 28 2" => ["D AMB", "IVOS"],
                        "Simiuisonna 29 2" => ["NSDS", "IVOS"],
                        "Simiuisonna 30 2" => ["DSNS", "IVOS"],
                        "Equos 1 2" => ["D", "IVOS"],
                        "Equos 2 2" => ["PRINI LAG", "IVOS"],
                        "Equos 3 2" => ["MD SIMIVIS", "IVOS"],
                        "Equos 4 2" => ["D", "IVOS"],
                        "Equos 5 2" => "D AMB",
                        "Equos 6 2" => "ITI MD SIMIVISO",
                        "Equos 7 2" => "D ELEMB",
                        "Equos 8 2" => "D ELEMB",
                        "Equos 9 2" => "D ELEMB",
                        "Equos 10 2" => "D",
                        "Equos 11 2" => "D AMB",
                        "Equos 12 2" => "D",
                        "Equos 13 2" => "IIT MD SIMI",
                        "Equos 14 2" => "MD SIMI",
                        "Equos 15 2" => "MD SIMI",
                        "Equos 16 2" => "MD SIMIVIS",
                        "Equos 17 2" => "TII MD SIMIVIS",
                        "Equos 18 2" => "ITI D AMB SIMIVIS",
                        "Equos 19 2" => "D",
                        "Equos 20 2" => "TII D AMB",
                        "Equos 21 2" => "IIT MD SIMIVIS",
                        "Equos 22 2" => "D ELEMB AMB",
                        "Equos 23 2" => "D ELEMB",
                        "Equos 24 2" => "D AMB ELEMB",
                        "Equos 25 2" => "D",
                        "Equos 26 2" => "D AMB",
                        "Equos 27 2" => "D",
                        "Equos 28 2" => "D AMB",
                        "Equos 29 2" => "D",
                        "Elembi 1 2" => ["D", "IVOS"],
                        "Elembi 2 2" => ["D", "IVOS"],
                        "Elembi 3 2" => ["PRINI LAG", "IVOS"],
                        "Elembi 4 2" => "D",
                        "Elembi 5 2" => "D AMB",
                        "Elembi 6 2" => "D",
                        "Elembi 7 2" => "ITI MD EDRINNI [TIOGBR?]",
                        "Elembi 8 2" => "IIT MD EDRI TIOCOBREXTIO",
                        "Elembi 9 2" => "MD EDRINNI",
                        "Elembi 10 2" => "N INIS R",
                        "Elembi 11 2" => "D AMB",
                        "Elembi 12 2" => "D",
                        "Elembi 13 2" => "D",
                        "Elembi 14 2" => "D",
                        "Elembi 15 2" => "D",
                        "Elembi 16 2" => "MD EDRIN",
                        "Elembi 17 2" => "MD EDRIN",
                        "Elembi 18 2" => "TII D EDRIN AMB",
                        "Elembi 19 2" => "D",
                        "Elembi 20 2" => "D AMB",
                        "Elembi 21 2" => "IIT D",
                        "Elembi 22 2" => "D EDRIN AMB",
                        "Elembi 23 2" => "MD EDRINI",
                        "Elembi 24 2" => "TII D AMB EDRINI",
                        "Elembi 25 2" => "D SINDIU IVOS",
                        "Elembi 26 2" => "D AMB",
                        "Elembi 27 2" => "D",
                        "Elembi 28 2" => "D AMB",
                        "Elembi 29 2" => "D",
                        "Aedrinni 1 2" => "D CANTLI",
                        "Aedrinni 2 2" => "MD",
                        "Aedrinni 3 2" => "MD",
                        "Aedrinni 4 2" => "MD",
                        "Aedrinni 5 2" => "D AMB",
                        "Aedrinni 6 2" => "PRINI LOUD",
                        "Aedrinni 7 2" => "D CANTI",
                        "Aedrinni 8 2" => "D CANTI",
                        "Aedrinni 9 2" => "D CANTI",
                        "Aedrinni 10 2" => "MD",
                        "Aedrinni 11 2" => "D AMB",
                        "Aedrinni 12 2" => "TII MD",
                        "Aedrinni 13 2" => "ITI MD",
                        "Aedrinni 14 2" => "IIT MD",
                        "Aedrinni 15 2" => "MD",
                        "Aedrinni 16 2" => "D ELEMB",
                        "Aedrinni 17 2" => "D ELEMB",
                        "Aedrinni 18 2" => "D AMB ELEMB",
                        "Aedrinni 19 2" => "ITI MD",
                        "Aedrinni 20 2" => "IIT D AMB",
                        "Aedrinni 21 2" => "IIT MD",
                        "Aedrinni 22 2" => "D CANTLAMB",
                        "Aedrinni 23 2" => "D CANTL",
                        "Aedrinni 24 2" => "D CANTLAMB",
                        "Aedrinni 25 2" => "ITI MD",
                        "Aedrinni 26 2" => "IIT D AMB",
                        "Aedrinni 27 2" => "MD",
                        "Aedrinni 28 2" => ["D AMB", "IVOS"],
                        "Aedrinni 29 2" => ["MD", "IVOS"],
                        "Aedrinni 30 2" => ["N", "IVOS"],
                        "Cantlos 1 2" => ["MD AEDRIN", "IVOS"],
                        "Cantlos 2 2" => ["D", "IVOS"],
                        "Cantlos 3 2" => ["D", "IVOS"],
                        "Cantlos 4 2" => "PRINI LAG",
                        "Cantlos 5 2" => "D AMB",
                        "Cantlos 6 2" => "D",
                        "Cantlos 7 2" => "SAMON PRINI LOUD",
                        "Cantlos 8 2" => "D DUMANI (SAMONI)",
                        "Cantlos 9 2" => "MD SAMONI",
                        "Cantlos 10 2" => "D",
                        "Cantlos 11 2" => "D AMB",
                        "Cantlos 12 2" => "D",
                        "Cantlos 13 2" => "D",
                        "Cantlos 14 2" => "D",
                        "Cantlos 15 2" => "D TIOCOBREXTIO",
                        "Cantlos 16 2" => "D",
                        "Cantlos 17 2" => "D",
                        "Cantlos 18 2" => "D AMB",
                        "Cantlos 19 2" => "N INIS R",
                        "Cantlos 20 2" => "D AMB",
                        "Cantlos 21 2" => "IIT D",
                        "Cantlos 22 2" => "D AMB SAMONI",
                        "Cantlos 23 2" => "N SAMONI INIS R",
                        "Cantlos 24 2" => "N SAMONI INIS R",
                        "Cantlos 25 2" => "D",
                        "Cantlos 26 2" => ["D AMB", "IVOS"],
                        "Cantlos 27 2" => ["D", "IVOS"],
                        "Cantlos 28 2" => ["D AMB", "IVOS"],
                        "Cantlos 29 2" => ["D", "IVOS"],
                        "Samonios 1 3" => ["D DUMANNI", "IVOS"],
                        "Samonios 2 3" => ["MD", "IVOS"],
                        "Samonios 3 3" => ["D EXINGI DUM", "IVOS"],
                        "Samonios 4 3" => ["MD", "IVOS"],
                        "Samonios 5 3" => "D AMB",
                        "Samonios 6 3" => "MD",
                        "Samonios 7 3" => "N DUMAN INIS R",
                        "Samonios 8 3" => "MD SAMONI",
                        "Samonios 9 3" => "D DUMANI",
                        "Samonios 10 3" => "MD",
                        "Samonios 11 3" => "D AMB",
                        "Samonios 12 3" => "MD",
                        "Samonios 13 3" => "TII MD",
                        "Samonios 14 3" => "ITI MD",
                        "Samonios 15 3" => "IIT MD",
                        "Samonios 16 3" => "D DUMANI",
                        "Samonios 17 3" => ["(M)D PRINI (TRINUX) SAM SINDIV", "(IVOS)"],
                        "Samonios 18 3" => "D AMB",
                        "Samonios 19 3" => "TII MD",
                        "Samonios 20 3" => "ITI D AMB",
                        "Samonios 21 3" => "IIT MD",
                        "Samonios 22 3" => "D DUM AMB",
                        "Samonios 23 3" => "D DUMANI",
                        "Samonios 24 3" => "N DUM INIS R",
                        "Samonios 25 3" => "TII MD",
                        "Samonios 26 3" => "ITI D AMB",
                        "Samonios 27 3" => "IIT MD",
                        "Samonios 28 3" => "D AMB",
                        "Samonios 29 3" => "MD",
                        "Samonios 30 3" => "D AMB",
                        "Dumanios 1 3" => "SAMON PRINI LOUD",
                        "Dumanios 2 3" => "D",
                        "Dumanios 3 3" => "D",
                        "Dumanios 4 3" => "D",
                        "Dumanios 5 3" => "PRINI LAG",
                        "Dumanios 6 3" => "D",
                        "Dumanios 7 3" => "MD RIVRI",
                        "Dumanios 8 3" => "MD RIVRI",
                        "Dumanios 9 3" => "MD RIVRI",
                        "Dumanios 10 3" => "D",
                        "Dumanios 11 3" => "N INIS R"
                        
                        }
                        
  
  #Adds ColignyMonth object, which has a name and number of days.
  class ColignyMonth
    attr_reader :name
    attr_accessor :days
    
    #Populate these attributes when the instance of ColignyMonth is created.
    def initialize(name, days)
      @name = name
      @days = days
    end
  end
  
  #Adds ColignyYear Class, which has attributes year, months(an array of ColignyMonth instances) and 
  class ColignyYear
    attr_accessor :months
    attr_reader :is_early
    
    #When an instance of ColignyYear is created, the year number MUST be specified,
    #and whether or not the metonic cycle is used CAN be specified, and is false by default.
    def initialize(year, is_metonic=false)
      #Stores the specified year number and metonic indicator.
      @is_metonic = is_metonic
      @year = year
      #Creates a "months" attribute and populates them with months standard to every Coligny year.    
      @months = [ColignyMonth.new("Samonios", 30), 
                 ColignyMonth.new("Dumanios", 29), 
                 ColignyMonth.new("Riuros", 30), 
                 ColignyMonth.new("Anagantios", 29), 
                 ColignyMonth.new("Ogronios", 30),
                 ColignyMonth.new("Cutios", 30),
                 ColignyMonth.new("Giamonios", 29),
                 ColignyMonth.new("Simiuisonna", 30),
                 ColignyMonth.new("Elembi", 29),
                 ColignyMonth.new("Aedrinni", 30),
                 ColignyMonth.new("Cantlos", 29)]
      
      #Calls method to determine whether year is before base year. (See lines 59-73)
      is_early?
      
      #Fills in missing months with methods depending on whether the metonic cycle is being used. (See lines )
      if !is_metonic           
        populate_saturn_months  
      else
        populate_metonic_months
      end  
    end
    
    private
    
    #Method to determine if year is before base year
    def is_early?
      if @is_metonic
        if (@year < 4999)
          @is_early = true 
        else
          @is_early = false
        end
      else
        if (@year < 4998)
          @is_early = true 
        else
          @is_early = false
        end
      end
    end
    
    #Method to determine how many years separate the year in question and the base year.
    def year_difference
      if @is_metonic
        if @is_early
          return 4999 - @year     
        else
          return @year - 4999
        end
      else
        if @is_early
          return 4998 - @year
        else
          return @year - 4998
        end
      end
    end
    
    
    def populate_saturn_equos
      if @is_early
        if (year_difference % 5 == 1) || (year_difference % 5 == 0) 
          @months.insert(8, ColignyMonth.new("Equos", 30))
        else
          @months.insert(8, ColignyMonth.new("Equos", 29))
        end
      elsif (year_difference % 5 == 0) || (year_difference % 5 == 4)
        @months.insert(8, ColignyMonth.new("Equos", 30))
      else
        @months.insert(8, ColignyMonth.new("Equos", 29))
      end
    end
    
    def populate_saturn_int1
      if year_difference % 5 == 0
        @months.unshift(ColignyMonth.new("Quimonios", 29))
      end
    end
    
    def populate_saturn_int2_check(cycle_repeat, cycle_limit, exception_cycle, exception_limit)
      if (year_difference % cycle_repeat == cycle_limit) && (year_difference % exception_cycle != exception_limit)
        return true
      else
        return false
      end
    end
    
    def populate_saturn_int2 
      if (@is_early && populate_saturn_int2_check(5, 3, 30, 3)) || (!@is_early && populate_saturn_int2_check(5, 2, 30, 27))
        @months.insert(6, ColignyMonth.new("Rantaranos", 30))
      end
    end
        
    def identify_year_locator(difference, years_between_instances)
      if @is_early
        if ((year_difference) % difference >= years_between_instances) || ((year_difference) % difference == 0)
          return true
        else
          return false
        end
      else
        if ((year_difference) % difference <= years_between_instances)
          return true
        else
          return false
        end
      end
    end
    
    def saturn_cycle_check(difference, years_between_instances, cycle, cycle_remainder)
      if identify_year_locator(difference, years_between_instances) && ((year_difference) >= difference) && ((year_difference) & cycle == cycle_remainder)
        return true
      else
        return false
      end
    end
    
    def saturn_longcycle_equos_check
      if (@is_early && saturn_cycle_check(198, 194, 5, 1)) || (!@is_early && saturn_cycle_check(198, 4, 5, 4))
        @months.find { |s| s.name == "Equos" }.days = 29
      end
    end
    
    def saturn_longcycle_int2_check
      if saturn_cycle_check(635, 29, 30, 27)
        @months.insert(6, ColignyMonth.new("Rantaranos", 30))
      end
    end
    
    def saturn_reverse_longcycle_int2_check
      if saturn_cycle_check(635, 606, 30, 3)
        @months.insert(6, ColignyMonth.new("Rantaranos", 30))
      end 
    end
     
    def populate_saturn_months 
      populate_saturn_equos
      populate_saturn_int1
      populate_saturn_int2
      saturn_longcycle_equos_check
           
      if @is_early
        saturn_reverse_longcycle_int2_check
      else        
        saturn_longcycle_int2_check
      end
    end
    
    def test_against_cases(cases)
      cases.each do |test|
        if (year_difference % 19) == test
          return true
        end
      end
      return false
    end
    
    def test_equos_days_metonic
      cases = [3,4,8,9,13,14,18]
      
      return test_against_cases(cases)
    end
    
    def test_intone_metonic
      cases = [4,9,14]
      
      return test_against_cases(cases)
    end
    
    def test_inttwo_metonic
      cases = [1,6,11,16]
      
      return test_against_cases(cases)
    end

    def test_earlier_than_start_equos_days_metonic
      cases = [1,5,6,10,11,15,16]
      
      return test_against_cases(cases)
    end
    
    def test_earlier_than_start_date_intone_metonic
      cases = [5,10,15]
      
      return test_against_cases(cases)
    end
    
    def test_earlier_than_start_date_inttwo_metonic
      cases = [3,8,13,18]
      
      return test_against_cases(cases)
    end
    
    def populate_metonic_equos
      if (@is_early && (test_earlier_than_start_equos_days_metonic)) || (!@is_early && (test_equos_days_metonic))
        @months.insert(8, ColignyMonth.new("Equos", 30))
      else
        @months.insert(8, ColignyMonth.new("Equos", 29))
      end
    end
    
    def populate_metonic_int1
      if (@is_early && test_earlier_than_start_date_intone_metonic) || (!@is_early && test_intone_metonic)
        @months.unshift(ColignyMonth.new("Quimonios", 29))
      end      
    end
    
    def populate_metonic_int2
      if (@is_early && test_earlier_than_start_date_inttwo_metonic) || (!@is_early && test_inttwo_metonic)
        @months.insert(6, ColignyMonth.new("Rantaranos", 30))
      end
    end
    
    def metonic_longcycle_early_year_check(frequency_of_adjustment, case_limiter)
      if ((year_difference % frequency_of_adjustment >= case_limiter) || (year_difference % frequency_of_adjustment == 0)) && (year_difference >= frequency_of_adjustment)
        return true
      else
        return false
      end
    end

    def metonic_longcycle_late_year_check(frequency_of_adjustment, case_limiter)
      if (year_difference % frequency_of_adjustment <= case_limiter) && (year_difference >= frequency_of_adjustment)
        return true
      else
        return false
      end
    end
    
    def metonic_longcycle_year_check(frequency_of_adjustment, case_limiter)
      if @is_early
        return metonic_longcycle_early_year_check(frequency_of_adjustment, case_limiter)
      else
        return metonic_longcycle_late_year_check(frequency_of_adjustment, case_limiter)
      end
    end
    
    def metonic_longcycle_int2_check
      if metonic_longcycle_year_check(6569, 4) && (@months[6].name == "Rantaranos")
        @months.delete_at(6)
      end
    end
    
    def metonic_longcycle_equos_check
      if (metonic_longcycle_year_check(61, 4) && test_earlier_than_start_date_inttwo_metonic) || (metonic_longcycle_year_check(61, 57) && test_inttwo_metonic)
        @months.find { |s| s.name == "Equos" }.days = 29
      end
    end
    
    def metonic_longcycle_reverse_int2_check
      if metonic_longcycle_year_check(6569, 6565) && (@months[6].name == "Rantaranos")
        @months.delete_at(6)
      end
    end
    
    def populate_metonic_months
      populate_metonic_equos
      populate_metonic_int1
      populate_metonic_int2
      metonic_longcycle_equos_check
      
      if @is_early
        metonic_longcycle_reverse_int2_check
      else
        metonic_longcycle_int2_check        
      end
    end
  end
  
  class ColignyDate
    attr_accessor :year, :day, :month, :months
    
    def initialize(year, month, day, is_metonic=false)
      @is_metonic = is_metonic
      @year = year
      @day = day
      if @is_metonic
        @start_year = 4999
        @start_date = Date.new(1999, 5, 22)
        @months = ColignyYear.new(year, true).months
      else
        @start_year = 4998
        @start_date = Date.new(1998, 5, 3)
        @months = ColignyYear.new(year).months
      end
      @month = @months.find { |s| s.name == month }
    end
    
    def days_exceed_over
      if @months[@months.index(@month) + 1].nil?
        @day = @day - @month.days
        @year += 1
        if @is_metonic
          @months = ColignyYear.new(@year, true).months
        else
          @months = ColignyYear.new(@year).months
        end
        @month = @months[0]
      else
        @day = @day - @month.days
        @month = @months[@months.index(@month) + 1]
      end
    end
    
    def days_exceed_under
      if @month == @months[0]
        @year -= 1
        if @is_metonic
          @months = ColignyYear.new(@year, true).months
        else
          @months = ColignyYear.new(@year).months
        end
        @month = @months[-1]
        @day = @month.days + (@day)
      else
        @month = @months[@months.index(@month) - 1]
        @day = @month.days + (@day)
      end
    end
    
    def calc_days(add)
      @day += add
      
      while @day > @month.days
        days_exceed_over
      end
      
      while @day < 1
        days_exceed_under
      end
    end
    
    def earlier_check(check_date) 
      day_count = 0
           
      until self.month.name == check_date.month.name && self.day == check_date.day && self.year == check_date.year
        self.calc_days(1)
        day_count += 1
      end
      
      return day_count
    end
    
    def later_check(check_date)
      day_count = 0
            
      until check_date.month.name == self.month.name && check_date.day == self.day && check_date.year == self.year
        check_date.calc_days(1)
        day_count += 1
      end
      
      return day_count
    end
  
    def to_gregorian_date   
      if @is_metonic
        start = ColignyDate.new(4999, "Samonios", 1, true)
      else
        start = ColignyDate.new(4998, "Quimonios", 1)
      end  
      
      if (@year < @start_year)
        return @start_date - earlier_check(start)
      else
        return @start_date + later_check(start)
      end    
    end
  end
  
  Date.class_eval do
    def to_coligny_date(is_metonic=false)    
      if is_metonic
        start = Date.new(1999, 5, 22)
        end_date = Date.new(self.year, self.month, self.mday)
        difference = (end_date - start).to_i
        
        start_coligny = ColignyDate.new(4999, "Samonios", 1, true)
        start_coligny.calc_days(difference)
        return start_coligny
      else
        start = Date.new(1998, 5, 3)
        end_date = Date.new(self.year, self.month, self.mday)
        difference = (end_date - start).to_i
        
        start_coligny = ColignyDate.new(4998, "Quimonios", 1)
        start_coligny.calc_days(difference)
        return start_coligny
      end
    end
  end
end
