mkdir cpp\build -Force
pushd cpp\build
cmake ..
cmake --build . --config=Release
Copy-Item .\Release\GMD3D11.dll ..\..\datafiles\GMD3D11.dll
popd
python.exe .\gmlgen.py
