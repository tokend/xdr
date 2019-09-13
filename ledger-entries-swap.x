%#include "xdr/types.h"

namespace stellar
{

struct SwapEntry
{
    uint64 swapID;

    Hash secretHash;

    AccountID sourceAccount;
    BalanceID sourceBalance;

    AccountID destinationAccount;
    BalanceID destinationBalance;

    AssetCode assetCode;
    uint64 amount;

    uint64 createdAt;
    uint64 lockTime;

	uint64 fee;
    uint64 percentFee;

    EmptyExt ext;
};
}
