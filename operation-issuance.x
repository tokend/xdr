

%#include "xdr/ledger-entries.h"

namespace stellar
{


/* IssuanceOp

   Result: IssuanceResult
*/
//: IssuanceOp is used to issuance specified amount of asset to a receiver's balance
struct IssuanceOp
{
    //: security type
    uint32 securityType;

    //: Code of an asset to issuance
    AssetCode asset;
    //: Amount to issuance
    uint64 amount;

    MovementDestination destination;

    longstring reference;

    //: Arbitrary stringified json object that can be used to attach data to be reviewed by an admin
    longstring creatorDetails; // details of the issuance (External system id, etc.)
    //: Total fee to pay, consists of fixed fee and percent fee, calculated automatically
    Fee fee; //totalFee to be payed (calculated automatically)
    //: Reserved for future use
    EmptyExt ext;
};

/******* Issuance Result ********/
//: Result codes of the IssuanceOp
enum IssuanceResultCode
{
    // codes considered as "success" for the operation
    //: Issuance operation application was successful
    SUCCESS = 0,
    
    // codes considered as "failure" for the operation
    //: Asset to issuance is not found
    ASSET_NOT_FOUND = -1,
    //: Trying to create an issuance request with negative/zero amount
    INVALID_AMOUNT = -2,
    //: Either the target balance is not found or there is a mismatch between the target balance asset and an asset in the request
    NO_COUNTERPARTY = -4,
    //: Source of operation is not an owner of the asset 
    NOT_AUTHORIZED = -5,
    //: Issuanced amount plus amount to issuance will exceed max issuance amount
    EXCEEDS_MAX_ISSUANCE_AMOUNT = -6,
    //: Amount to issuance plus amount on balance would exceed UINT64_MAX 
    RECEIVER_FULL_LINE = -7,
    //: Creator details are not valid JSON
    INVALID_CREATOR_DETAILS = -8,
    //: Fee is greater than the amount to issuance
    FEE_EXCEEDS_AMOUNT = -9,
    INVALID_AMOUNT_PRECISION = -10,
    INVALID_REFERENCE = -11,
    REFERENCE_DUPLICATION = -12
};

//:Result of successful application of Issuance operation
struct IssuanceSuccess {

    //: Account address of the receiver
    AccountID receiver;
    BalanceID receiverBalance;

    //: Paid fee
    Fee fee;
    //: Reserved for future use
    EmptyExt ext;
};
//: Create issuance request result with result code
union IssuanceResult switch (IssuanceResultCode code)
{
case SUCCESS:
    IssuanceSuccess success;
default:
    void;
};
}

