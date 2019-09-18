%#include "xdr/types.h"

namespace stellar
{

struct SwapEntry
{
    uint64 id;

    Hash secretHash;

    AccountID source;
    BalanceID sourceBalance;

    BalanceID destinationBalance;

    longstring details;

    uint64 amount;

    int64 createdAt;
    int64 lockTime;

	uint64 fee;

    EmptyExt ext;
};
}
