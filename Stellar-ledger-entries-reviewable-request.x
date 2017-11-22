// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-types.h"
%#include "xdr/Stellar-reviewable-request-asset.h"

namespace stellar
{

enum ReviewableRequestType
{
    ASSET_CREATE = 0,
	ASSET_UPDATE = 1
};

// ReviewableRequest - request reviewable by admin
struct ReviewableRequestEntry {
	uint64 ID;
	Hash hash; // hash of the request body
	AccountID requestor;
	string256 rejectReason;

	union switch (ReviewableRequestType type) {
		case ASSET_CREATE:
			AssetCreationRequest assetCreationRequest;
		case ASSET_UPDATE:
			AssetUpdateRequest assetUpdateRequest;
	} body;

	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
