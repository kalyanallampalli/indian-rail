# Indian::Rail

Indian Rail is a simple wrapper for finding out India train details. Please see the documentation for the proper input arguments and expected output.

## Installation

Add this line to your application's Gemfile:

    gem 'indian-rail'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install indian-rail

## Usage

To enquire the PNR status of your journey *ticket*:

	response = IndianRail::Pnr.enquiry "pnr_number"
	
Train Schedule methods will accept either train number or train name to find the schedule of a particular *Train*:

	response = IndianRail::Schedule.find "train_number"
	
Or
	response = IndianRail::Schedule.find "train_name"
	
IndianRail will return a hash filled result something like this:
	
	{:pnr=>"XXXXXXX", :train_no=>"XXXX", :train_name=>"EXP", :boarding_date=>"DD-MM-YYYY", :from=>"XXX", :to=>"YYY", :reserved_upto=>"XXX"}

You can even send proxy details, if you are working under proxy server

	response = IndianRail::Schedule.find "train-number", :proxy => {:url => "proxy.example.com", :port => 'port_number'}
	
## MIT License

Copyright (c) 2013 Kalyan Allampalli

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.