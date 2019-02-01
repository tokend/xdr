// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-types.h"

namespace stellar
{

struct AssetCreationRequest {

	AssetCode code;
	AccountID preissuedAssetSigner;
	uint64 maxIssuanceAmount;
	uint64 initialPreissuedAmount;
    uint32 policies;
    longstring creatorDetails; // details set by requester
    uint64 type;

	uint32 sequenceNumber;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    case ADD_ASSET_BALANCE_PRECISION:
        uint32 trailingDigitsCount;
    }
    ext;
};

struct AssetUpdateRequest {
	AssetCode code;
    longstring creatorDetails; // details set by requester
	uint32 policies;

	uint32 sequenceNumber;
	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct AssetChangePreissuedSigner
{
	AssetCode code;
	AccountID accountID;
	DecoratedSignature signature;

	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
