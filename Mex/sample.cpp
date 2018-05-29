

#include "mex.h"
#include  <stdio.h>
#include <sstream>
#include <string>

using namespace std;

#define MEX_ARGS int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs


// Do CHECK and throw a Mex error if check fails
inline void mxCHECK(bool expr, const char* msg) {
	if (!expr) {
		mexErrMsgTxt(msg);
	}
}
inline void mxERROR(const char* msg) { mexErrMsgTxt(msg); }
static void creat_xml(MEX_ARGS)
{
	mxCHECK(nrhs == 1, "Usage: MATMGC('creat_xml')");
	char* record = mxArrayToString(prhs[0]);
	CreatXmlFile(record);

}
static void analyze_beat_v1(MEX_ARGS)
{
	mxCHECK(nrhs == 2, "Usage: MATMGC('analyze_beat_v1')");
	int beat[250];
	double *x = mxGetPr(prhs[0]);
	for (int i = 0; i < 250; i++)
	{
		beat[i] = x[i];
	//	printf("%d ", beat[i]);
	}

	double *rr = mxGetPr(prhs[1]);
//	printf("\n");
//	int onset, offset, isoLevel, beatBegin, beatEnd, ramp;

	
	plhs[0] = mxCreateDoubleMatrix(1,9, mxREAL);
	plhs[1] = mxCreateDoubleMatrix(1, 3, mxREAL);
	double *y1 = mxGetPr(plhs[0]);
	double *y2 = mxGetPr(plhs[1]);

	int pos[9]; int A[3];
	ptdetector(beat,rr[0] , pos, A);
	for (int i = 0; i < 9; i++)
		y1[i] = pos[i];
	 y2[0] = A[0];
	 y2[1] = A[1];
	 y2[2] = A[2];

}

// Usage: matmgc('version')
static void version(MEX_ARGS) {
	mxCHECK(nrhs == 0, "Usage: matmgc('version')");
	// Return version string
	plhs[0] = mxCreateString("Version2.0.0");
}

void help(MEX_ARGS)
{
	mxCHECK(nrhs == 0, "Usage: matmgc('help')\r\n");
	// Return version string
	plhs[0] = mxCreateString("Version1.0.1");
}


/*==================================================================
** matlab entry point.
==================================================================*/


struct handler_registry {
	string cmd;
	void(*func)(MEX_ARGS);
};
static handler_registry handlers[] = {
	// Public API functions
	{"help",                     help         },
	{"version",                  version      },
	{"af_AFEV",                  af_AFEV      },
	{"beat_detector",            beat_detector},
	{"file_analysis",            file_analysis},
	{"creat_xml" ,               creat_xml },
	{"creat_qrs",                creat_qrs },
	{"creat_qrs_v2",             creat_qrs_v2},
	{"mit_bxb",                  bxb},
	{"write_mit_annot",           write_mit_annot},
	{"read_mit_annot" ,           read_mit_annot },
	{"analyze_beat_v1",           analyze_beat_v1 },
	{ "creat_medianwave",           creat_medianwave }
	

	
};
void mexFunction(MEX_ARGS) {

	string x;

	//mexLock();  // Avoid clearing the mex file.
	mxCHECK(nrhs > 0, "Usage: MatMgc(api_command, arg1, arg2, ...)");
	// Handle input command
	char* cmd = mxArrayToString(prhs[0]);
	bool dispatched = false;
	// Dispatch to cmd handler
	for (int i = 0; handlers[i].func != NULL; i++) {
		if (handlers[i].cmd.compare(cmd) == 0) {
			handlers[i].func(nlhs, plhs, nrhs - 1, prhs + 1);
			dispatched = true;
			break;
		}
	}
	if (!dispatched) {
		ostringstream error_msg;
		error_msg << "Unknown command '" << cmd << "'";
		mxERROR(error_msg.str().c_str());
	}
	//mxFree(cmd);
}