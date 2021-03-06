// <ACEStransformID>urn:ampas:aces:transformId:v1.5:IDT.Sony.Venice_SLog3_SGamut3.a1.v1</ACEStransformID>
// <ACESuserName>ACES 1.0 Input - Sony Venice S-Log3 S-Gamut3</ACESuserName>

// Provided by Sony Electronics Corp.
//

//------------------------------------------------------------
//  VENICE S-Gamut3 to AP0 matrix coeffs
//------------------------------------------------------------
const float matrixCoef[3][3] =
{
	{  0.7933297411,  0.0155810585, -0.0188647478 },
	{  0.0890786256,  1.0327123069,  0.0127694121 },
	{  0.1175916333, -0.0482933654,  1.0060953358 }
};

//------------------------------------------------------------------------------------
//  S-Log 3 to linear
//------------------------------------------------------------------------------------
float SLog3_to_linear( float SLog )
{
	float out;

	if (SLog >= 171.2102946929 / 1023.0)
	{
		out = pow(10.0, (SLog*1023.0-420.0)/261.5)*(0.18+0.01)-0.01;
	}
	else
	{
		out = (SLog*1023.0-95.0)*0.01125000/(171.2102946929-95.0);
	}

	return out;
}

//------------------------------------------------------------------------------------
//  main
//------------------------------------------------------------------------------------
void main (
	input varying float rIn,
	input varying float gIn,
	input varying float bIn,
	input varying float aIn,
	output varying float rOut,
	output varying float gOut,
	output varying float bOut,
	output varying float aOut )
{
	float SLog3[3];
	SLog3[0] = rIn;
	SLog3[1] = gIn;
	SLog3[2] = bIn;

	float linear[3];
	linear[0] = SLog3_to_linear( SLog3[0] );
	linear[1] = SLog3_to_linear( SLog3[1] );
	linear[2] = SLog3_to_linear( SLog3[2] );

	float ACES[3] = mult_f3_f33( linear, matrixCoef );

	rOut = ACES[0];
	gOut = ACES[1];
	bOut = ACES[2];
	aOut = aIn;
}