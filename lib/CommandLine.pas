// The MIT License
//
// Copyright (c) 2011 Albert Almeida (caviola@gmail.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

unit CommandLine;

interface

  type

    TParseArgumentCallback = procedure( var p : integer; const arg : string ) of object;
    TParseOptionCallback   = procedure( var p : integer; const option : string ) of object;

  procedure ParseCommandLine( ParseOptionCallback : TParseOptionCallback;
                             ParseArgumentCallback : TParseArgumentCallback );

implementation

  procedure ParseCommandLine( ParseOptionCallback : TParseOptionCallback;
                              ParseArgumentCallback : TParseArgumentCallback );
    var
      p     : integer;
      param : string;
    begin
      assert( assigned( ParseOptionCallback ) );
      assert( assigned( ParseArgumentCallback ) );
      p := 1;
      while p <= ParamCount do
        begin
          param := ParamStr( p );
          if param[1] in ['-','/']
            then ParseOptionCallback( p, copy( param, 2, length( param ) - 1 ) )
            else ParseArgumentCallback( p, param );
          inc( p );
        end;
    end;

end.
