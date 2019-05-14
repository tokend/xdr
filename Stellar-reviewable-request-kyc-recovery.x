%#include "xdr/Stellar-types.h"
%#include "xdr/Stellar-operation-manage-signer.h"

namespace stellar
{

//: KYCRecoveryRequest is used to change signers of operation source account
struct KYCRecoveryRequest {

    AccountID targetAccount;

    UpdateSignerData signersData<>;

    //: Arbitrary stringified json object that can be used to attach data to be reviewed by an admin
    longstring creatorDetails; // details set by requester

    uint64 sequenceNumber;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}

