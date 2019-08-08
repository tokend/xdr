%#include "xdr/types.h"
namespace stellar
{

struct RecoveryOp
{
    //: Account for which signers will be set
    AccountID targetAccount;
    
    PublicKey key;

    AccountID recoveryProviders<>;

    uint64 power;

    EmptyExt ext;
};

//: Result codes of CreateKYCRecoveryRequestOp
enum RecoveryResultCode
{
    //: KYC Recovery request was successfully created
    SUCCESS = 0,

    //: Account with provided account address does not exist
    TARGET_ACCOUNT_NOT_FOUND = -1
};


//: Result of operation applying
union RecoveryResult switch (RecoveryResultCode code)
{
case SUCCESS:
    EmptyExt ext;
default:
    void;
};

}
