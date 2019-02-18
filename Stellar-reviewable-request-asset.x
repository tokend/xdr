

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
    uint32 trailingDigitsCount;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
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
