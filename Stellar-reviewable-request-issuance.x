

%#include "xdr/Stellar-types.h"

namespace stellar
{

struct PreIssuanceRequest {
	AssetCode asset;
	uint64 amount;
	DecoratedSignature signature;
	string64 reference;
    longstring creatorDetails; // details set by requester

	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};
//: Contains details regarding issuance 
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
