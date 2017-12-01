// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

// ManageAssetAction - specifies action to be performed over asset or asset create/update request
enum ManageAssetAction
{
    CREATE_ASSET_CREATION_REQUEST = 0,
    CREATE_ASSET_UPDATE_REQUEST = 1,
	CANCEL_ASSET_REQUEST = 2
};

// CancelAssetRequest - cancels update or create request
struct CancelAssetRequest {

	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/* ManageAssetOp

    Creates, updates or deletes asset

    Threshold: high

    Result: ManageAssetResult
*/

struct ManageAssetOp
{
	uint64 requestID; // 0 to create, non zero will try to update
    union switch (ManageAssetAction action)
	{
	case CREATE_ASSET_CREATION_REQUEST:
		AssetCreationRequest createAsset;
	case CREATE_ASSET_UPDATE_REQUEST:
		AssetUpdateRequest updateAsset;
	case CANCEL_ASSET_REQUEST:
		CancelAssetRequest cancelRequest;
	} request;

	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ManageAsset Result ********/

enum ManageAssetResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,                       // request was successfully created/updated/canceled

    // codes considered as "failure" for the operation
	REQUEST_NOT_FOUND = -1,           // failed to find asset request with such id
	ASSET_ALREADY_EXISTS = -3,			   // asset with such code already exist
    INVALID_MAX_ISSUANCE_AMOUNT = -4, // max issuance amount is 0
	INVALID_CODE = -5,                // asset code is invalid (empty or contains space)
	INVALID_NAME = -6,                // asset name is invalid (empty)
	INVALID_POLICIES = -7,            // asset policies (has flag which does not belong to AssetPolicies enum)
	ASSET_NOT_FOUND = -8
};

struct ManageAssetSuccess
{
	uint64 requestID;
    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};


union ManageAssetResult switch (ManageAssetResultCode code)
{
case SUCCESS:
    ManageAssetSuccess success;
default:
    void;
};

}
