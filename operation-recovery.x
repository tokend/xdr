%#include "xdr/types.h"
namespace stellar
{

struct RecoveryOp
{
    //: Account for which signers will be set
    AccountID targetAccount;
    
    PublicKey key;

    AccountID recoveryProviders<>;

    uint64 recoveryPower;

    EmptyExt ext;
};

//: Result codes of CreateKYCRecoveryRequestOp
enum RecoveryResultCode
{
    //: KYC Recovery request was successfully created
    SUCCESS = 0,

    //: Account with provided account address does not exist
    TARGET_ACCOUNT_NOT_FOUND = -1,
    NO_RECOVERY_PROVIDERS = -2,
    INVALID_RECOVERY_POWER = -3
};

struct RecoverySuccess {
    EmptyExt ext;
};

//: Result of operation applying
union RecoveryResult switch (RecoveryResultCode code)
{
case SUCCESS:
    RecoverySuccess success;
default:
    void;
};

}
