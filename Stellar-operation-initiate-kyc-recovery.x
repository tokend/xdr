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

    //: KYC target account not found
    NOT_FOUND = -1,
    //: Only admin can submit InitiateKYCRecovery
    NOT_AUTHORIZED = -2,
    //: System configuration forbids KYC recovery
    RECOVERY_NOT_ALLOWED = -3,
    //: Either, there is no entry by key `kyc_recovery_account_role`, or such role does not exists
    RECOVERY_ACCOUNT_ROLE_NOT_FOUND = -4
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
