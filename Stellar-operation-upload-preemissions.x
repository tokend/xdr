// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* UploadPreemissionsOp

    Threshold: high

    Result: UploadPreemissionResult
*/

struct PreEmission
{
    string64 serialNumber;
    AssetCode asset;
    int64 amount;
    DecoratedSignature signatures<20>;
	// reserved for future use
	union switch (LedgerVersion v)
	{
	case EMPTY_VERSION:
		void;
	}
	ext;
};

struct UploadPreemissionsOp
{
    PreEmission preEmissions<>;
	// reserved for future use
	union switch (LedgerVersion v)
	{
	case EMPTY_VERSION:
		void;
	}
	ext;
};

/******* UploadPreemissions Result ********/

enum UploadPreemissionsResultCode
{
    // codes considered as "success" for the operation
    UPLOAD_PREEMISSIONS_SUCCESS = 0,

    // codes considered as "failure" for the operation
    UPLOAD_PREEMISSIONS_MALFORMED = -1,
    UPLOAD_PREEMISSIONS_SERIAL_DUPLICATION = -2,    // serial is already used
    UPLOAD_PREEMISSIONS_MALFORMED_PREEMISSIONS = -3, // if pre-emissions has empty signatures or zero amount etc
    UPLOAD_PREEMISSIONS_ASSET_NOT_FOUND = -4,
    UPLOAD_PREEMISSIONS_LINE_FULL = -5
};

union UploadPreemissionsResult switch (UploadPreemissionsResultCode code)
{
case UPLOAD_PREEMISSIONS_SUCCESS:
    struct {
		// reserved for future use
		union switch (LedgerVersion v)
		{
		case EMPTY_VERSION:
			void;
		}
		ext;
	} success;
default:
    void;
};

}
