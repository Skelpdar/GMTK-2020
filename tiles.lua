--[ This holds the code for our hexagonal levels
--
--]

--[
--Directions for rails:
--  1  6
--2      5
--  3  4
--
--]

local example_tracks_tileset = {{{2,4},  {}, {},      {}},
								 {{},   {1,4}, {},       {}},
								{{},     {}, {1,3,5}, {2,5}},
								 {{5 }, {2,6}, {},       {}}}

local example_elements_tileset = {{{},             {}, {},            {}},
								  {   {},            {},            {}, {}},
								  {{},             {}, {"switch3-5"}, {}},
								  {   {"bluetrain"},   {}, {}, {}}}



