%#include "xdr/types.h"

namespace stellar
{

//: InitiateKYCRecoveryOp is used to start KYC recovery process
struct InitiateKYCRecoveryOp
{
    //: Address of account to be recovered
    AccountID account;
    //: New signer to set
    PublicKey signer;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: Result codes of InitiateKYCRecoveryOp
enum InitiateKYCRecoveryResultCode
{
    //: Means that KYC recovery was successfully initiated
    SUCCESS = 0,

    //: System configuration forbids KYC recovery
    RECOVERY_NOT_ALLOWED = -1,
    //: Either, there is no entry by key `kyc_recovery_signer_role`, or such role does not exists
    RECOVERY_SIGNER_ROLE_NOT_FOUND = -2
};

//: Result of operation applying
union InitiateKYCRecoveryResult switch (InitiateKYCRecoveryResultCode code)
{
case SUCCESS:
    struct
    {
         //: reserved for future use
         union switch (LedgerVersion v)
         {
         case EMPTY_VERSION:
             void;
         } ext;
    } success;
default:
    void;
};

}
