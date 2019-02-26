%#include "xdr/Stellar-types.h"

namespace stellar
{

//: Is used pass needed values to perform pre issuance
struct PreIssuanceRequest
{
    //: Code of asset which available for issuance amount will increase
    AssetCode asset;
    //: Amount which will be added to current available for issuance amount
    uint64 amount;
    //: Content signature of pre issuer signer
    //: Content equals hash of `<reference>:<amount>:<asset>`
    DecoratedSignature signature;
    //: Unique string for such type of reviewable request
    string64 reference;
    //: Arbitrary stringified json object provided by requester
    longstring creatorDetails; // details set by requester

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct IssuanceRequest {
	AssetCode asset;
	uint64 amount;
	BalanceID receiver;
	longstring creatorDetails; // details of the issuance (External system id, etc.)
	Fee fee; //totalFee to be payed (calculated automatically)
	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
