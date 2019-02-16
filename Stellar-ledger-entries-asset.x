

%#include "xdr/Stellar-types.h"

namespace stellar
{

enum AssetPolicy
{
	TRANSFERABLE = 1,
	BASE_ASSET = 2,
	STATS_QUOTE_ASSET = 4,
	WITHDRAWABLE = 8,
	ISSUANCE_MANUAL_REVIEW_REQUIRED = 16,
	CAN_BE_BASE_IN_ATOMIC_SWAP = 32,
	CAN_BE_QUOTE_IN_ATOMIC_SWAP = 64
};


struct AssetEntry
{
    AssetCode code;
	AccountID owner;
	AccountID preissuedAssetSigner; // signer of pre issuance tokens
	longstring details;
	uint64 maxIssuanceAmount; // max number of tokens to be issued
	uint64 availableForIssueance; // pre issued tokens available for issuance
	uint64 issued; // number of issued tokens
	uint64 pendingIssuance; // number of tokens locked for entries like token sale. lockedIssuance + issued can not be > maxIssuanceAmount
    uint32 policies;
    uint64 type; // use instead policies that limit usage, use in account rules
    uint32 trailingDigitsCount;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
