%{
This should help to get the mex cmd running with mac
(I re-installed xcode before)
The solution follows the guide found in that link:
https://uk.mathworks.com/matlabcentral/answers/512901-mex-xcodebuild-error-sdk-macosx10-15-4-cannot-be-located

You can find the path for your mexopt with:
%}

compilerCfg = mex.getCompilerConfigurations;
disp('change the following files:')
compilerCfg(1).MexOpt 
compilerCfg(2).MexOpt 

%{
do the following:

cd <your path to the files>
vi mex_C++_maci64.xml
vi mex_C_maci64.xml

PRESS "i" to change file (INSERT)

In that file configure:

this: CHANGE THIS ONE

        <SDKVER>
            <cmdReturns name="xcrun -sdk macosx --show-sdk-version"/>
        </SDKVER>

to this:
        <SDKVER>
            <cmdReturns name="xcrun -sdk macosx --show-sdk-version | cut -c1-5"/>
        </SDKVER>

AFTER change PRESS "<esc>:wq" to save your changes

%}

input('Press enter when u finished your changes')
mex -setup C++
mex -setup C

%{

To build the mexfile you need to run:
mex <gateway file> <additional source files>
mex mexFlanger.c flanger.c

%}
