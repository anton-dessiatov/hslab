fmap :: (a -> b) -> f a -> f b
f <$> x = fmap f x

ap :: f (a -> b) -> f a -> f b
f <*> x = ap f x

(>>=) :: m a -> (a -> m b) -> m b
