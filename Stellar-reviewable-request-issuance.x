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
    //: Pre issuer signer's signature of the `<reference>:<amount>:<asset>` hash
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
//: Body of reviewable IssuanceRequest, contains parameters regarding issuance
struct IssuanceRequest {
    //: Code of asset to issue
	AssetCode asset;
   //: Amount to issue
	uint64 amount;
    //: Balance to issue to
	BalanceID receiver;
    //: Arbitrary stringified json object that can be used to attach data to be reviewed by the admin
	longstring creatorDetails; // details of the issuance (External system id, etc.)
    //: Total fee to pay, consists of fixed fee and percent fee, calculated automatically
	Fee fee; //totalFee to be payed (calculated automatically)
	//: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
  ext;
};

}
