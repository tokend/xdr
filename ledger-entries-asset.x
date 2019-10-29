

%#include "xdr/types.h"

namespace stellar
{

enum AssetPolicy
{
	TRANSFERABLE = 1,
	WITHDRAWABLE = 8,
	ISSUANCE_MANUAL_REVIEW_REQUIRED = 16
};


struct AssetEntry
{
    AssetCode code;
	AccountID owner;
	longstring details;
	uint64 maxIssuanceAmount; // max number of tokens to be issued
	uint64 issued; // number of issued tokens
    uint32 policies;
	uint32 state; // smth that can be used to disable asset
    uint32 securityType; // use instead policies that limit usage, use in account rules
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
