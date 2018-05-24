%#include "xdr/Stellar-ledger-entries.h"

namespace stellar {

/* ManagePolicyAttachment

    Create or delete policy attachment for any account, specific account type or account id

    Threshold: high

    Result: ManagePolicyAttachmentResult
*/

enum ManagePolicyAttachmentAction {
    CREATE_POLICY_ATTACHMENT = 0,
    DELETE_POLICY_ATTACHMENT = 1
};

struct CreatePolicyAttachment {
    uint64 policyID;

    union switch (PolicyAttachmentType type) {
        case FOR_ANY_ACCOUNT:
            void;
        case FOR_ACCOUNT_TYPE:
            AccountType accountType;
        case FOR_ACCOUNT_ID:
            AccountID accountID;
    } actor;

    // reserved for future use
    union switch (LedgerVersion v) {
    case EMPTY_VERSION:
        void;
    } ext;
};

struct DeletePolicyAttachment {
    uint64 policyAttachmentID;

    // reserved for future use
    union switch (LedgerVersion v) {
    case EMPTY_VERSION:
        void;
    } ext;
};

struct ManagePolicyAttachmentOp {
    union switch (ManagePolicyAttachmentAction action) {
        case CREATE_POLICY_ATTACHMENT:
            CreatePolicyAttachment creationData;
        case DELETE_POLICY_ATTACHMENT:
            DeletePolicyAttachment deletionData;
    } opInput;

    // reserved for future use
    union switch (LedgerVersion v) {
    case EMPTY_VERSION:
        void;
    } ext;
};

enum ManagePolicyAttachmentResultCode {
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    POLICY_NOT_FOUND = -1, // policy with required policyID not found or source isn't the owner of the policy
    POLICY_ATTACHMENTS_LIMIT_EXCEEDED = -2, // policy attachments limit exceeded for operation source account
    DESTINATION_ACCOUNT_NOT_FOUND = -3, // account for policy attachment not found
    ATTACHMENT_ALREADY_EXISTS = -4, // policy attachment with provided params already exists
    POLICY_ATTACHMENT_NOT_FOUND = -5
};

struct ManagePolicyAttachmentSuccess {
    uint64 policyAttachmentID;

    union switch (LedgerVersion v) {
    case EMPTY_VERSION:
        void;
    } ext;
};

union ManagePolicyAttachmentResult switch (ManagePolicyAttachmentResultCode code) {
    case SUCCESS:
        ManagePolicyAttachmentSuccess managePolicyAttachmentSuccess;
    default:
        void;
};

}