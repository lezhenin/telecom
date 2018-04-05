close all

n = 15
A = rand(n, 2)
[U,S,V] = svd(A)

figure
hold on
plot(A(:, 1), A(:, 2), 'bo')
plotv(V(:, 1) * -5)
plotv(V(:, 2) * -5)
axis([-0.1, 1.1, -0.1, 1.1])