%#include "xdr/Stellar-types.h"

namespace stellar {

enum PolicyAttachmentType {
    FOR_ANY_ACCOUNT = 1,
    FOR_ACCOUNT_TYPE = 2,
    FOR_ACCOUNT_ID = 3
};

struct PolicyAttachmentEntry {
    uint64 policyAttachmentID;
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
    }
    ext;
};

}