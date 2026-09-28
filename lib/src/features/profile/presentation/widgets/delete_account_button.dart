import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mood_journal_app/src/app/routes/app_routes.dart';
import 'package:mood_journal_app/src/core/services/firebase/account_deletion_service.dart';

class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    if (GetStorage().read<bool>('isGuest') ?? false) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final dangerColor = theme.colorScheme.error;

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        leading: Icon(
          Icons.security_outlined,
          color: theme.colorScheme.primary,
        ),
        title: const Text('Account and data'),
        subtitle: const Text('Manage permanent account actions'),
        childrenPadding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
        children: [
          Divider(color: theme.dividerColor.withValues(alpha: 0.4)),
          const SizedBox(height: 8),
          Text(
            'Deleting your account permanently removes your profile and all '
            'signed-in journal data. Open this action only when needed.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => Get.dialog(const _DeleteAccountDialog()),
              icon: const Icon(Icons.delete_outline_rounded),
              label: const Text('Delete my account'),
              style: OutlinedButton.styleFrom(
                foregroundColor: dangerColor,
                side: BorderSide(color: dangerColor.withValues(alpha: 0.5)),
                padding: const EdgeInsets.symmetric(vertical: 13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DeleteAccountDialog extends StatefulWidget {
  const _DeleteAccountDialog();

  @override
  State<_DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<_DeleteAccountDialog> {
  final _passwordController = TextEditingController();
  bool _isDeleting = false;
  bool _obscurePassword = true;
  String? _error;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _deleteAccount() async {
    final password = _passwordController.text;
    if (password.isEmpty) {
      setState(() => _error = 'Enter your password to confirm deletion.');
      return;
    }

    setState(() {
      _isDeleting = true;
      _error = null;
    });

    try {
      await AccountDeletionService.instance.deleteCurrentAccount(password);
      Get.offAllNamed(AppRoutes.login);
      Get.snackbar(
        'Account deleted',
        'Your cloud account and journal data were permanently deleted. '
            'Photos and Nilora data saved on this device were also removed.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on FirebaseAuthException catch (error) {
      if (!mounted) return;
      setState(() {
        _error = switch (error.code) {
          'wrong-password' ||
          'invalid-credential' => 'The password is incorrect.',
          'too-many-requests' => 'Too many attempts. Try again later.',
          'network-request-failed' => 'Check your internet connection.',
          _ => 'Account deletion could not be verified. Try again.',
        };
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _error = 'Account deletion failed. Please try again.');
    } finally {
      if (mounted) setState(() => _isDeleting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dangerColor = theme.colorScheme.error;

    return AlertDialog(
      scrollable: true,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      icon: Container(
        width: 58,
        height: 58,
        decoration: BoxDecoration(
          color: dangerColor.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.warning_amber_rounded, color: dangerColor, size: 30),
      ),
      title: const Text('Delete your account?', textAlign: TextAlign.center),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('This action is permanent. Nilora will remove:'),
          const SizedBox(height: 12),
          const _DeletionItem(label: 'Your Firebase account and cloud profile'),
          const _DeletionItem(label: 'All cloud mood and journal entries'),
          const _DeletionItem(
            label: 'Your profile photo and Nilora data stored on this device',
          ),
          const SizedBox(height: 4),
          Text(
            'Nilora does not upload your photo files to its server.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'Enter your password to confirm.',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            enabled: !_isDeleting,
            autofocus: false,
            textInputAction: TextInputAction.done,
            onSubmitted: _isDeleting ? null : (_) => _deleteAccount(),
            decoration: InputDecoration(
              labelText: 'Current password',
              hintText: 'Enter your password',
              errorText: _error,
              prefixIcon: const Icon(Icons.lock_outline_rounded),
              suffixIcon: IconButton(
                tooltip: _obscurePassword ? 'Show password' : 'Hide password',
                onPressed: _isDeleting
                    ? null
                    : () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _isDeleting ? null : _deleteAccount,
              style: FilledButton.styleFrom(
                backgroundColor: dangerColor,
                foregroundColor: theme.colorScheme.onError,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: _isDeleting
                  ? SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: theme.colorScheme.onError,
                      ),
                    )
                  : const Text('Yes, delete account'),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: _isDeleting ? null : Get.back,
              child: const Text('Cancel'),
            ),
          ),
        ],
      ),
    );
  }
}

class _DeletionItem extends StatelessWidget {
  const _DeletionItem({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.close_rounded,
            size: 18,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(label)),
        ],
      ),
    );
  }
}
