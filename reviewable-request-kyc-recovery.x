%#include "xdr/types.h"
%#include "xdr/operation-manage-signer.h"

namespace stellar
{

//: KYCRecoveryRequest is used to change signers of target account
struct KYCRecoveryRequest {
    //: Account to be recovered
    AccountID targetAccount;
    //: New signers for the target account
    UpdateSignerData signersData<>;

    //: Arbitrary stringified json object that can be used to attach data to be reviewed by an admin
    longstring creatorDetails; // details set by requester
    //: Sequence number increases when request is rejected
    uint32 sequenceNumber;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}

