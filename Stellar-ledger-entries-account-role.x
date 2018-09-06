%#include "xdr/Stellar-types.h"

namespace stellar {

struct AccountRoleEntry {
    uint64 accountRoleId;
    string accountRoleName<>;
    AccountID ownerID;

    // reserved for future use
    union switch (LedgerVersion v) {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}